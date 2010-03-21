CHAT = { }

Commands = 
{
	changeradiofreq = "rp_changefrequency",
	dropweapon = "rp_dropweapon",
	restartmap = "rp_restartmap",
	setflag = "rp_setcombineflag",
	rpnick = "rp_rpnick",
	givemoney = "rp_givemoney",
	listflags = "rp_listflags",
	spawnitem = "rp_spawnitem",
	newdoor = "rp_newdoor",
	doorname = "rp_doorname",
	storewep = "rp_storewep",
	tooltrust = "rp_tooltrust",
	physguntrust = "rp_physguntrust",
	businesstrust = "rp_businesstrust",
	setoocdelay = "rp_oocdelay"
}

function TalkIC( pos, range )
	local plys = {}
	
	for k, v in pairs( player.GetAll() ) do
		if ( v:GetPos():Distance( pos ) < range ) then
			table.insert( plys, v )
		end
	end
	
	return plys
end

function GM:PlayerSay( ply, text, public )
	self.BaseClass:PlayerSay( ply, text )
	
	if ( string.find( text, "!" ) == 1 ) then
		local command = string.sub( string.Explode( " ", text )[ 1 ], 2 )
		if Commands[ command ] then
			ply:ConCommand( Commands[ command ] .. string.sub( text, string.len( command ) + 2 ) )
			return ""
		else
			ply:PrintChat( "Invalid Command", false )
			return ""
		end
	end
	
	local exp = string.Explode( " ", text )
	if ( CHAT[ exp[ 1 ] ] ) then
		local len = string.len( text )
		local sub = string.len( exp[ 1 ] ) + 2
		CHAT[ exp[ 1 ] ]( ply, exp, string.sub( text, sub, len ) )
		return ""
	else
		for _, pl in pairs( player.GetAll() ) do
			if ( ply:GetPos():Distance( pl:GetPos() ) < 150 ) then
				pl:SendChatText( Color( 151, 211, 255, 255 ), ply:Nick(), Color( 151, 211, 255, 255 ), ": " .. ply:CheckGrammar( text ) )

			end
		end
	end
	
	return ""
end

CHAT[ "//" ] = function( ply, args, text )
	if( ply.LastOOC + Config[ "oocdelay" ] < CurTime() ) then
		ply.LastOOC = CurTime()
		for k, v in pairs( player.GetAll() ) do
			v:SendChatText( team.GetColor( ply:Team() ), ply:Nick(), Color( 255, 255, 255, 255 ), " [OOC]: ", Color( 255, 255, 255, 255 ), text )

		end
	else
		local TimeLeft = math.ceil( ply.LastOOC + Config[ "oocdelay" ] - CurTime() )
		ply:PrintChat( "Please wait " .. TimeLeft .. " seconds before using OOC again!", false )
		return
	end
end
CHAT[ "/ooc" ] = CHAT[ "//" ]
CHAT[ "/OOC" ] = CHAT[ "//" ]
CHAT[ "((" ] = CHAT[ "//" ]

CHAT[ "/r" ] = function( ply, args, text )
	if ( ply:HasItem( "radio" ) ) then
		for k, v in pairs( player.GetAll() ) do
			if ( v:GetNWInt( "Frequency" ) == ply:GetNWInt( "Frequency" ) and v:HasItem( "radio" ) ) then
				v:SendChatText( Color( 151, 211, 255, 255 ), "[Radio] ", Color( 151, 211, 255, 255 ), ply:Nick(), Color( 151, 211, 255, 255 ), ": ", Color( 151, 211, 255, 255 ), text )

			end
		end
	else
		ply:PrintChat( "You don't have a radio.", false )
		return
	end
end
CHAT[ "/radio" ] = CHAT[ "/r" ]
CHAT[ "/rad" ] = CHAT[ "/r" ]

CHAT[ "/cr" ] = function( ply, args, text )
	if ( ply:HasItem( "crdevice" ) ) then
		for k, v in pairs( player.GetAll() ) do
			v:SendChatText( Color( 255, 75, 75, 255 ), "[REQUEST]: ", Color( 151, 211, 255, 255 ), text )

			v:PrintConsole( ply:Nick() .. " made a request with his/her cr device.", true )
		end
	end
end
CHAT[ "/cradio" ] = CHAT[ "/cr" ]
CHAT[ "/crad" ] = CHAT[ "/cr" ]

CHAT[ "/w" ] = function( ply, args, text )
	for k, v in pairs( TalkIC( ply:GetPos(), 80 ) ) do
		v:SendChatText( Color( 151, 211, 255, 255 ), " [Whisper] ", Color( 151, 211, 255, 255 ), ply:Nick(), Color( 151, 211, 255, 255 ), ": ", Color( 151, 211, 255, 255 ), text )

	end
end

CHAT[ "/y" ] = function( ply, args, text )
	for k, v in pairs( TalkIC( ply:GetPos(), 450 ) ) do
		v:SendChatText( Color( 151, 211, 255, 255 ), "[Yell] ", Color( 151, 211, 255, 255 ), ply:Nick(), Color( 151, 211, 255, 255 ), ": ", Color( 151, 211, 255, 255 ), text )

	end
end

CHAT[ ".//" ] = function( ply, args, text )
	for k, v in pairs( TalkIC( ply:GetPos(), 200 ) ) do
		v:SendChatText( Color( 151, 211, 255, 255 ), "[Local-OOC] ", Color( 151, 211, 255, 255 ), ply:Nick(), Color( 151, 211, 255, 255 ), ": ", Color( 151, 211, 255, 255 ), text )

	end
end
CHAT[ "[[" ] = CHAT[ ".//" ]
CHAT[ "/looc" ] = CHAT[ ".//" ]

CHAT[ "/me" ] = function( ply, args, text )
	for k, v in pairs( TalkIC( ply:GetPos(), 90 ) ) do
		v:SendChatText( Color( 151, 211, 255, 255 ), "** ", Color( 151, 211, 255, 255 ), ply:Nick(), Color( 151, 211, 255, 255 ), ": ", Color( 151, 211, 255, 255 ), text )

	end
end

CHAT[ "/ad" ] = function( ply, args, text )
	if ( ply:GetNWInt( "Credits" ) > 20 ) then
		ply:TakeCredits( 20 )
		
		for k, v in pairs( player.GetAll() ) do
			if ( v:IsAdmin() ) then
				v:PrintConsole( ply:Nick() .. " made a advert.", true )
			end
			v:SendChatText( Color( 255, 75, 75, 255 ), "[Advert]: ", Color( 151, 211, 255, 255 ), text )

			ply:PrintChat( "You havce spent 20 credits on an advert.", false )
		end
	else
		ply:PrintChat( "Not enough credits, you need 20 credits.", false )
		return
	end
end
CHAT[ "/advert" ] = CHAT[ "/ad" ]

CHAT[ "/br" ] = function( ply, args, text )
	if ( ply:Team() == 10  ) then
		for k, v in pairs( player.GetAll() ) do
			v:SendChatText( Color( 255, 75, 75, 255 ), "[BROADCAST]: ", Color( 151, 211, 255, 255 ), text )

			v:PrintConsole( ply:Nick() .. " made a broadcast.", true )
		end
	end
end
CHAT[ "/broadcasr" ] = CHAT[ "/br" ]

CHAT[ "/dis" ] = function( ply, args, text )
	if ( ply:IsCombine() ) then
		for k, v in pairs( player.GetAll() ) do
			v:SendChatText( Color( 255, 75, 75, 255 ), "[DISPATCH]: ", Color( 151, 211, 255, 255 ), text )
			v:PrintConsole( ply:Nick() .. " made a dispatch.", true )
		end
	end
end
CHAT[ "/dispatch" ] = CHAT[ "/dis" ]
CHAT[ "/di" ] = CHAT[ "/dis" ]

CHAT[ "/citizen" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag c\n" )
	return ""
end

CHAT[ "/cwu" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag cwu\n" )
	return ""
end

CHAT[ "/vort" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag vort\n" )
	return ""
end

CHAT[ "/rct" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag rct\n" )
	return ""
end

CHAT[ "/cca" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag cca\n" )
	return ""
end

CHAT[ "/sql" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag sql\n" )
	return ""
end

CHAT[ "/cmd" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag cmd\n" )
	return ""
end

CHAT[ "/ow" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag ow\n" )
	return ""
end

CHAT[ "/eow" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag eow\n" )
	return ""
end

CHAT[ "/ca" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag ca\n" )
	return ""
end

CHAT[ "/re" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag r\n" )
	return ""
end

CHAT[ "/rel" ] = function( ply, args, text )
		RunConsoleCommand( "rp_flag rl\n" )
	return ""
end

CHAT[ "/give" ] = function( ply, args, text )
	local tr = ply:EyeTrace( 90 )
	if not ( ValidEntity( tr.Entity ) and tr.Entity:IsPlayer() ) then	end
		if ( ply:GetNWInt( "Credits" ) > tonumber( args[ 1 ] ) ) then
			tr.Entity:GiveCredits( math.floor( args[ 1 ] ) )
			tr.Entity:PrintChat( "You have recieved " .. math.floor( args[ 1 ] ) .. " credits from " .. ply:Nick(), false )
			ply:TakeCredits( math.floor( args[ 1 ] ) )
			ply:PrintChat( "You gave " .. tr.Entity:Nick() .. " " .. math.floor( args[ 1 ] ) .. " credits", false )
		end
	return ""
end

CHAT[ "/save" ] = function( ply, args, text )
		RunConsoleCommand( "rp_savemanual" )
	return ""
end
CHAT[ "/savemanual" ] = CHAT[ "/save" ]

--[[ChatCommands = {}

function AddChatCommand(cmd, callback, prefixconst)
	table.insert(ChatCommands, { cmd = cmd, callback = callback, prefixconst = prefixconst })
end

function GM:PlayerSay(ply, text)
	self.BaseClass:PlayerSay(ply, text)

	for k, v in pairs(ChatCommands) do
		if v.cmd == string.Explode(" ", string.lower(text))[1] then
			return v.callback(ply, "" .. string.sub(text, string.len(v.cmd) + 2, string.len(text)))
		end
	end

		TalkToRange(ply:Nick() .. ": " .. text, ply:GetPos(), 250)
		return ""
end

function Whisper(ply, args)
	TalkToRange("[WHISPER] " .. ply:Nick() .. ": " .. args, ply:EyePos(), 90)

	return ""
end
AddChatCommand("/w", Whisper)

function Me(ply, args)
	TalkToRange("** " .. ply:Nick() .. " " .. args .. " **", ply:EyePos(), 140)

	return ""
end
AddChatCommand("/me", Me)

function LOOC(ply, args)
	TalkToRange("[Local-OOC] " .. ply:Nick() .. ": " .. args, ply:EyePos(), 280)

	return ""
end
AddChatCommand(".//", LOOC)

function Yell(ply, args)
	TalkToRange("[YELL] " .. ply:Nick() .. ": " .. args, ply:EyePos(), 550)

	return ""
end
AddChatCommand("/y", Yell)

function Advert(ply, args)
	TalkToRange("[ADVERT] " .. " " .. args, ply:EyePos(), 100000)

	return ""
end
AddChatCommand("/adv", AD)
AddChatCommand("/ad", AD)
AddChatCommand("/advert", Advert)

function Dispatch(ply, args)
	if ply:IsCombine() then
		TalkToRange("[Dispatch] " .. ply:Nick() .. ": " .. args, ply:EyePos(), 180)
		
		return ""
	end
end
AddChatCommand("/dis", Dispatch)
AddChatCommand("/di", Dispatch)
AddChatCommand("/dispatch", Dispatch)

function Radio(ply, args)
	if ply:Team() == TEAM_FIREMAN or ply:Team() == TEAM_POLICE or ply:Team() == TEAM_SWAT then
		for k, v in pairs(player.GetAll()) do
			if v:Team() == TEAM_FIREMAN or v:Team() == TEAM_POLICE or v:Team() == TEAM_SWAT then
				v:ChatPrint(ply:Name() .. ": (RADIO) " .. args)
				v:PrintMessage(2, ply:Name() .. ": (RADIO) " .. args)
			end
		end
	end

	return ""
end
AddChatCommand("/r", Radio)

function OOC(ply, args)
	if( ply.LastOOC + Config[ "oocdelay" ] < CurTime() ) then
			ply.LastOOC = CurTime()
		for k, v in pairs( player.GetAll() ) do
			end
		return "[OOC] " .. args
	else
		local TimeLeft = math.ceil( ply.LastOOC + Config[ "oocdelay" ] - CurTime() )
			ply:PrintChat( "Please wait " .. TimeLeft .. " seconds before using OOC again!", false )
		return false
	end
end
AddChatCommand("//", OOC)
AddChatCommand("/a ", OOC)
AddChatCommand("/ooc", OOC)
--]]