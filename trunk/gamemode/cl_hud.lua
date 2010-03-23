surface.CreateFont( "coolvetica", 21, 500, true, false, "StatFont" );
surface.CreateFont( "Tahoma", 20, 1000, true, false, "KFont" );
surface.CreateFont( "Tahoma", 20, 1000, true, false, "KFont2" );
surface.CreateFont( "TargetID", 48, 800, true, false, "FontHuge" );
surface.CreateFont( "TargetID", 26, 800, true, false, "FontSmall" );
surface.CreateFont( "ChatFont", 26, 800, true, false, "FontMed" );

function DrawAmmoInfo()
	
	local pri = 0;
	local ammo = nil;

	if( LocalPlayer():GetActiveWeapon():IsValid() ) then
		ammo = LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType();
	end

	if( LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():Clip1() > 0 ) then
		pri = LocalPlayer():GetActiveWeapon():Clip1();
	end
	
	if( LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetClass() == "hands" ) then
	
	pri = 0;
	
	end
	
	surface.SetFont( "KFont" );
	local w, h = surface.GetTextSize( pri );
	local prisize = w;

    if(pri == 0) then return; end

		draw.RoundedBox( 4, ScrW() - 35 - 15, ScrH() - 63, 50, 38, Color( 0, 0, 0, 200 ) );
		draw.DrawText( pri, "KFont", ScrW() - 10  - 5, ScrH() - 63, Color( 255, 255, 255, 255 ), 2 );

end

RickDarktokenStart = -1;
RickDarktokenEnd = 5;
RickDarktokenAlpha = 255;
RickDarktokenDrawn = false;

function DrawFIFO()

	if( CurTime() > FadeStart and CurTime() < FadeEnd ) then
		FIFOAlpha = math.Clamp( FIFOAlpha + ( 600 * FrameTime() ), 0, 255 );
	end
	
	if( CurTime() > FadeStart and CurTime() > FadeEnd and FadeStart > 0 ) then
		FIFOAlpha = math.Clamp( FIFOAlpha - ( 150 * FrameTime() ), 0, 255 );
		
		if( not RickDarktokenDrawn ) then
			CinematicBarDesiredHeight = 120;
			CinematicBarHeight = 120;
		end
		
		if( FIFOAlpha < 1 and not RickDarktokenDrawn ) then
			RickDarktokenStart = CurTime();
			RickDarktokenEnd = CurTime() + 5;
			RickDarktokenDrawn = true;
		end
	end

	draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0, FIFOAlpha ) );
	
	draw.DrawText( "Welcome to " .. game.GetMap(), "GiantTargetID", ScrW() / 2, ScrH() / 2, Color( 255, 255, 255, FIFOAlpha ), 1, 1 );
	draw.DrawText( "It's safer here", "BigTargetID", ScrW() / 2, ScrH() / 2 + 40, Color( 255, 255, 255, FIFOAlpha ), 1, 1 );
	
end

function GM:HUDDrawTargetID()	
	local ply = LocalPlayer()
	
	if ( ply:Alive() ) then
		local tr = ply:GetEyeTrace()
		local Distance = 150
		
		if ( tr.Entity:IsValid() ) then
			if ( tr.Entity:IsPlayer() ) then
				local Alpha = math.Clamp( 255 - ( ( 255 / Distance ) * tr.Entity:GetShootPos():Distance( ply:GetShootPos() ) ), 0, 255 )
				local x, y = self:GetScreenCenterBounce()
				local TargetTeam = team.GetColor( tr.Entity:Team() )
				
				draw.DrawText( tr.Entity:Nick(), "TargetID", x, y, Color( TargetTeam.r, TargetTeam.g, TargetTeam.b, Alpha ) )
				if( LocalPlayer().Tied == true ) then
					draw.DrawText( "Tied up.", "TargetID", x, y + 50, Color( 255, 0, 0, 255), 1 )
				end
			end
			if ( tr.Entity:GetModel() == 'models/props_misc/clock-1.mdl' or tr.Entity:GetModel() == 'models/props_trainstation/clock01.mdl' or tr.Entity:GetModel() == 'models/props_c17/clock01.mdl' or tr.Entity:GetModel() == 'models/props_combine/breenclock.mdl' or tr.Entity:GetModel() == 'models/props_trainstation/trainstation_clock001.mdl' ) then
				local Alpha = math.Clamp( 150 - ( ( 10 / Distance ) * tr.Entity:GetPos():Distance( ply:GetShootPos() ) ), 0, 255 )
				local x, y = self:GetScreenCenterBounce()
				
				draw.DrawText( GetGlobalString( "time" ), "FontSmall", x, y, Color( 255, 0, 0, Alpha ) )
			end
			if ( tr.Entity:IsItem() ) then
				local Alpha = math.Clamp( 255 - ( ( 255 / Distance ) * tr.Entity:GetPos():Distance( ply:GetShootPos() ) ), 0, 255 )
				local x, y = self:GetScreenCenterBounce()
				
				draw.DrawText( tr.Entity:GetNWString( "Name" ), "KFont", x, y, Color( 255, 0, 0, 255) )
				draw.DrawText( tr.Entity:GetNWString( "Description" ), "KFont", x, y + 13, Color( 255, 255, 255, 255) )
				draw.DrawText( "Press E", "KFont", x, y + 28, Color( 200, 0, 0, 255) )
			end
			
			if ( tr.Entity:IsDoor() ) then
				local Alpha = math.Clamp( 255 - ( ( 255 / Distance ) * tr.Entity:GetPos():Distance( ply:GetShootPos() ) ), 0, 255 )
				local x, y = self:GetScreenCenterBounce()
				draw.DrawText( tr.Entity:GetNWString( "doorname" ), "FontMed", x + 2, y + 2, Color( 7, 7, 7, 255 ) )
				draw.DrawText( tr.Entity:GetNWString( "doorname" ), "FontMed", x + 4, y + 5, Color( 7, 7, 7, 255 ) )
				draw.DrawText( tr.Entity:GetNWString( "doorname" ), "FontMed", x + 3, y + 3, Color( 200, 0, 0, 255 ) )
				
				if ( tr.Entity:GetNWBool( "Owned" ) == false ) then
					draw.DrawText( "Price: " .. tr.Entity:GetNWInt( "doorcost" ), "FontMed", x + 2, y + 2, Color( 7, 7, 7, 255 ) )
					draw.DrawText( "Price: " .. tr.Entity:GetNWInt( "doorcost" ), "FontMed", x + 4, y + 5, Color( 7, 7, 7, 255 ) )
					draw.DrawText( "Price: " .. tr.Entity:GetNWInt( "doorcost" ), "FontMed", x + 3, y + 3, Color( 150, 0, 0, 255 ) )
				end
			end
		end
	end
end

local function DrawDamageColour()
	local modify = { }
	local color = 0.75
	
	if ( LocalPlayer():Health() < 40 ) then
		if ( LocalPlayer():Alive() ) then
			color = math.Clamp( color - ( ( 50 - LocalPlayer():Health() ) * 0.025 ), 0, color )
		else
			color = 0.75
		end
		
		DrawMotionBlur( math.Clamp( 1 - ( ( 50 - LocalPlayer():Health() ) * 0.025 ), 0.1, 1 ), 1, 0 )
	end
	
	modify[ "$pp_colour_addr" ] = 0
	modify[ "$pp_colour_addg" ] = 0
	modify[ "$pp_colour_addb" ] = 0
	modify[ "$pp_colour_brightness" ] = 0
	modify[ "$pp_colour_contrast" ] = 1.1
	modify[ "$pp_colour_colour" ] = color
	modify[ "$pp_colour_mulr" ] = 0
	modify[ "$pp_colour_mulg" ] = 0
	modify[ "$pp_colour_mulb" ] = 0
	
	DrawColorModify( modify )
end

local function DrawDeathColor()
	if ( !LocalPlayer():Alive() ) then
		local tab = {}
		local dcolor = 0
		
		tab[ "$pp_colour_addr" ] 		= 0
		tab[ "$pp_colour_addg" ] 		= 0
		tab[ "$pp_colour_addb" ] 		= 0
		tab[ "$pp_colour_brightness" ] 	= 0
		tab[ "$pp_colour_contrast" ] 	= 1.1
		tab[ "$pp_colour_colour" ] 		= dcolor
		tab[ "$pp_colour_mulr" ] 		= 0
		tab[ "$pp_colour_mulg" ] 		= 0
		tab[ "$pp_colour_mulb" ] 		= 0
		
		DrawColorModify( tab )
	end
end
--usermessage.Hook( "DeathColor", DeathColor );

function GM:HUDPaint( )
	self.BaseClass:HUDPaint(ply)

	local hx = 9
	local hy = ScrH() - 25
	local hw = 190
	local hh = 10
	
	if ( !LocalPlayer():Alive() ) then
		return
	end

	if LocalPlayer():Health() > 0 then
		draw.RoundedBox(4, hx -6, hy - 104, hw + 10, hh + 8, Color(0, 0, 0, 200))
		draw.RoundedBox(2, hx, hy - 100, math.Clamp(hw * (LocalPlayer():Health() / 100), 0, 190), hh, Color(150, 0, 0, 200))
	end

	if LocalPlayer():Armor() > 0 then
		draw.RoundedBox(4, hx -6, hy - 84, hw + 10, hh + 8, Color(0, 0, 0, 200))
		draw.RoundedBox(2, hx, hy - 80, math.Clamp(hw * (LocalPlayer():Armor() / 100), 0, 190), hh, Color(150, 150, 0, 200))
	end
	
	draw.RoundedBox(4, hx -6, hy - 64, hw + 40, hh + 45, Color(0, 0, 0, 200))
	draw.DrawText( LocalPlayer():Nick()  .. "\n" .. " " .. LocalPlayer():GetNWInt("credits") .. " Dollars", "KFont2", hx , hy - 59, Color(255, 255, 255, 200), 0)

	DrawDamageColour()
	DrawDeathColor()
	DrawAmmoInfo()
	
	if ( LocalPlayer().Tied ) then
		draw.DrawText( "Tied up", "TargetID", ScrW( ) / 2 - 93, 6, Color( 150, 0, 0, 255 ) )
	end

	for k, v in pairs( player.GetAll() ) do
		if ( v != LocalPlayer() ) then
			if ( v:Alive() ) then
				local alpha = math.Clamp( 255 - ( ( 255 / 250 ) * v:GetShootPos():Distance( LocalPlayer():GetShootPos() ) ), 0, 255 )
				local x = v:GetShootPos():ToScreen().x
				local y = v:GetShootPos():ToScreen().y
				
				if( v:GetNWBool( "ChatOpen" ) == true ) then
					draw.DrawText( "Typing...", "TargetID", x, y - 115, Color( 255, 255, 255, 255 ), 1 )
				end
			end
		end
	end
end

function GM:HUDShouldDraw( hidez )
	local Hide = 
	{
		"CHudHealth",
		"CHudAmmo",
		"CHudSecondaryAmmo",
		"CHudBattery",
		"CHudSuitPower"
	}
	
	for k, v in pairs( Hide ) do
		if ( hidez == v ) then
			return false
		end
	end
	
	return true
end

