TIME = {}
TIME.ClockDay = math.random(1,25)
TIME.ClockMonth = math.random(1,12)
TIME.ClockYear = 2010
TIME.ClockMins = 480

function ccSetTime(ply, command, args)
	
end

local daylight = {  };
local DAY_LENGTH	= 60 * 24; // 24 hours
local DAY_START		= 5 * 60; // 5:00am
local DAY_END		= 18.5 * 60; // 6:30pm
local DAWN			= ( DAY_LENGTH / 4 );
local DAWN_START	= DAWN - 144;
local DAWN_END		= DAWN + 144;
local NOON			= DAY_LENGTH / 2;
local DUSK			= DAWN * 3;
local DUSK_START	= DUSK - 144;
local DUSK_END		= DUSK + 144;
local LIGHT_LOW		= string.byte( 'b' );
local LIGHT_HIGH	= string.byte( 'z' );

daylight.dayspeed = CreateConVar( 'daytime_speed', '30', { FCVAR_REPLICATED , FCVAR_ARCHIVE , FCVAR_NOTIFY } );

util.PrecacheSound( 'buttons/button1.wav' );

function daylight:init( )
	
	timer.Create("sendtime", 1, 0, function()
		local nHours = string.format("%02.f", math.floor(TIME.ClockMins / 60))
		local nMins = string.format("%02.f", math.floor(TIME.ClockMins - (nHours*60)))
		local timez
		
		if(tonumber(nHours) > 12) then 
		
			nHours = nHours - 12
			timez = "PM"
			
		else
		
			timez = "AM"
			
		end
		
		if(tonumber(nHours) == 0) then
		
			nHours = 12
			
		end
		
		SetGlobalString("time", TIME.ClockMonth .. "." .. TIME.ClockDay .. "." .. TIME.ClockYear .. " - " .. nHours .. ":" .. nMins .. timez)
	end)	
	
	self.nextthink = 0;
	
	if( TIME.ClockMins == nil ) then
		TIME.ClockMins = 1;
	end
	
	self.light_environment = ents.FindByClass( 'light_environment' );
	
	if ( self.light_environment ) then
		local light;
		for _ , light in pairs( self.light_environment ) do
			light:Fire( 'FadeToPattern' , string.char( LIGHT_LOW ) , 0 );
			light:Activate( );
		end
	end
	
	self.env_sun = ents.FindByClass( 'env_sun' );
	
	if ( self.env_sun ) then
		local sun;
		for _ , sun in pairs( self.env_sun ) do
			sun:SetKeyValue( 'material' , 'sprites/light_glow02_add_noz.vmt' );
			sun:SetKeyValue( 'overlaymaterial' , 'sprites/light_glow02_add_noz.vmt' );
		end
	end
	
	self.sky_overlay = ents.FindByName( 'skyoverlay*' );
	
	if ( self.sky_overlay ) then
		local brush;
		for _ , brush in pairs( self.sky_overlay ) do
			brush:Fire( 'Enable' , '' , 0 );
			brush:Fire( 'Color' , '0 0 0' , 0.01 );
		end
	end

	self:buildLightTable( );
	
	self.ready = true;
end

function daylight:buildLightTable( )

	self.light_table = {  };
	
	local i;
	for i = 1 , DAY_LENGTH do
		self.light_table[ i ] = {  };
		
		local letter = string.char( LIGHT_LOW );
		local red = 0;
		local green = 0;
		local blue = 0;
		
		if ( i >= DAY_START && i < NOON ) then
			local progress = ( NOON - i ) / ( NOON - DAY_START );
			local letter_progress = 1 - math.EaseInOut( progress , 0 , 1 );
						
			letter = ( ( LIGHT_HIGH - LIGHT_LOW ) * letter_progress ) + LIGHT_LOW;
			letter = math.ceil( letter );
			letter = string.char( letter );
		elseif ( i  >= NOON && i < DAY_END ) then
		
			local progress = ( i - NOON ) / ( DAY_END - NOON );
			local letter_progress = 1 - math.EaseInOut( progress , 0 , 1 );
						
			letter = ( ( LIGHT_HIGH - LIGHT_LOW ) * letter_progress ) + LIGHT_LOW;
			letter = math.ceil( letter );
			letter = string.char( letter );
		end
		
		if ( i >= DAWN_START && i <= DAWN_END ) then
			local frac = ( i - DAWN_START ) / ( DAWN_END - DAWN_START );
			if ( i < DAWN ) then
				red = 200 * frac;
				green = 128 * frac;
			else
				red = 200 - ( 200 * frac );
				green = 128 - ( 128 * frac );
			end
		elseif ( i >= DUSK_START && i <= DUSK_END ) then
			local frac = ( i - DUSK_START ) / ( DUSK_END - DUSK_START );
			if ( i < DUSK ) then
				red = 85 * frac;
			else
				red = 85 - ( 85 * frac );
			end
		elseif ( i >= DUSK_END || i <= DAWN_START ) then
			if ( i > DUSK_END ) then
				local frac = ( i - DUSK_END ) / ( DAY_LENGTH - DUSK_END );
				blue = 30 * frac;
			else
				local frac = i / DAWN_START;
				blue = 30 - ( 30 * frac );
			end
		end
		
		self.light_table[ i ].pattern = letter;
		self.light_table[ i ].sky_overlay_alpha = math.floor( 255 * math.Clamp( math.abs( ( i - NOON ) / NOON ) , 0 , 0.7 ) );
		self.light_table[ i ].sky_overlay_color = math.floor( red ) .. ' ' .. math.floor( green ) .. ' ' .. math.floor( blue );
		
		self.light_table[ i ].env_sun_angle = ( i / DAY_LENGTH ) * 360;
		self.light_table[ i ].env_sun_angle = self.light_table[ i ].env_sun_angle + 90;
		if ( self.light_table[ i ].env_sun_angle > 360 ) then
			self.light_table[ i ].env_sun_angle = self.light_table[ i ].env_sun_angle - 360;
		end
		self.light_table[ i ].env_sun_angle = 'pitch ' .. self.light_table[ i ].env_sun_angle;
	end
end

function get_days_in_month( month )
  local days_in_month = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }   
  local d = days_in_month[ month ]
  return d
end

function daylight:think( )
	// not ready to think?
	if ( !self.ready || self.nextthink > CurTime( ) ) then return; end
	
	local daylen = daylight.dayspeed:GetFloat( );
	
	self.nextthink = CurTime( ) + ( ( daylen / 1440 ) * 60 );
	
	TIME.ClockMins = TIME.ClockMins + 1;
	
	if ( TIME.ClockMins > DAY_LENGTH ) then
		TIME.ClockMins = 1
		TIME.ClockDay = TIME.ClockDay + 1
	end
	
	if ( TIME.ClockDay >= get_days_in_month( TIME.ClockMonth ) ) then 
		TIME.ClockMonth = TIME.ClockMonth + 1
		TIME.ClockDay = 1
	end
	if ( TIME.ClockMonth > 12 ) then 
		TIME.ClockYear = TIME.ClockYear + 1
		TIME.ClockMonth = 1
	end
	
	TIME.ClockTime = DAY_START + TIME.ClockMins - 1
	
	local pattern = self.light_table[ TIME.ClockMins ].pattern;

	if ( self.light_environment && self.pattern != pattern ) then
		local light;
		for _ , light in pairs( self.light_environment ) do
			light:Fire( 'FadeToPattern' , pattern , 0 );
			light:Activate( );
		end
	end

	self.pattern = pattern;

	local sky_overlay_alpha = self.light_table[ TIME.ClockMins ].sky_overlay_alpha;
	local sky_overlay_color = self.light_table[ TIME.ClockMins ].sky_overlay_color;

	if ( self.sky_overlay ) then
		local brush;
		for _ , brush in pairs( self.sky_overlay ) do
			if ( self.sky_overlay_alpha != sky_overlay_alpha ) then
				brush:Fire( 'Alpha' , sky_overlay_alpha , 0 );
			end
			
			if ( self.sky_overlay_color != sky_overlay_color ) then
				brush:Fire( 'Color' , sky_overlay_color , 0 );
			end
		end
	end

	self.sky_overlay_alpha = sky_overlay_alpha;
	self.sky_overlay_color = sky_overlay_color;

	local env_sun_angle = self.light_table[ TIME.ClockMins ].env_sun_angle;

	if ( self.env_sun && self.env_sun_angle != env_sun_angle ) then
		local sun;
		for _ , sun in pairs( self.env_sun ) do
			sun:Fire( 'addoutput' , env_sun_angle , 0 );
			sun:Activate( );
		end
	end

	self.env_sun_angle = env_sun_angle;

	if ( TIME.ClockMins == DAWN ) then
		self:lightsOff( );
	elseif ( TIME.ClockMins == DUSK ) then
		self:lightsOn( );
	end
end

function daylight:checkNightLight( ent , key , val )
	if ( !string.find( ent:GetClass( ) , 'light' ) ) then return; end
	
	self.nightlights = self.nightlights or {  };
	
	if ( key == 'nightlight' ) then
		local name = ent:GetClass( ) .. '_nightlight' .. ent:EntIndex( );
//		ent:SetKeyValue( 'targetname' , name );
		table.insert( self.nightlights , { ent = ent , style = val } );
		ent:Fire( 'TurnOn' , '' , 0 );
	end
end

function daylight:lightsOn( )
	if ( !self.nightlights ) then return; end
	
	local function flicker( ent )
		local new_pattern;
		
		if ( math.random( 1 , 2 ) == 1 ) then
			new_pattern = 'az';
		else
			new_pattern = 'za';
		end
		
		local delay = math.random( 0 , 400 ) * 0.01;
		
		ent:Fire( 'SetPattern' , new_pattern , delay );
		ent:Fire( 'TurnOn' , '' , delay );

		timer.Simple( delay , function( ) ent:EmitSound( 'buttons/button1.wav' , math.random( 70 , 80 ) , math.random( 95 , 105 ) ) end );
		
		delay = delay + math.random( 10 , 50 ) * 0.01;

		ent:Fire( 'SetPattern' , 'z' , delay );
	end
	
	local light;
	for _ , light in pairs( self.nightlights ) do
		flicker( light.ent );
	end
end

function daylight:lightsOff( )
	if ( !self.nightlights ) then return; end
	
	local light;
	for _ , light in pairs( self.nightlights ) do
		light.ent:Fire( 'TurnOff' , '' , 0 );
	end
end

hook.Add( 'InitPostEntity' , 'daylight:init' , function( ) daylight:init( ); end );
hook.Add( 'Think' , 'daylight:think' , function( ) daylight:think( ); end );
hook.Add( 'EntityKeyValue' , 'daylight:checkNightLight' , function( ent , key , val ) daylight:checkNightLight( ent , key , val ); end );
