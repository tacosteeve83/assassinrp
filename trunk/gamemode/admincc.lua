function Kick( ply, cmd, args )
	if ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )
	if ( Target ) then
		if ( !args[ 2 ] ) then
			game.ConsoleCommand( string.format( "kickid %s \"Kicked by %s\"\n", Target:UserID(), ply:Name() ) )
		else
			game.ConsoleCommand( string.format( "kickid %s \"%s\"\n", Target:UserID(), args[ 2 ] ) )
		end
	end
end
end
concommand.Add( "rp_kick", Kick )

function Ban( ply, cmd, args )
	if ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )
	
	if ( Target ) then
		if ( !args[ 2 ] ) then
			game.ConsoleCommand( string.format( "banid 0 %s\n", Target:UserID() ) )
			game.ConsoleCommand( string.format( "kickid %s \"Banned permanently by %s\"\n", Target:UserID(), ply:Name() ) )
			game.ConsoleCommand( "writeid\n" )
		else
			game.ConsoleCommand( string.format( "banid 60 %s\n", Target:UserID() ) )
			game.ConsoleCommand( string.format( "kickid %s \"Banned for 1 hour by %s\"\n", Target:UserID(), ply:Name() ) )
			game.ConsoleCommand( "writeid\n" )
		end
	end
end
end
concommand.Add( "rp_ban", Ban )

function GivePhysgunTrust( ply, cmd, args )
	if ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )
	
	if ( Target ) then
		if ( args[ 2 ] == "1" ) then
			Target:SetPlayerField( "physguntrust", 1 )
			Target:Give( "weapon_physgun" )
			Target:PrintChat( ply:Nick() .. " gave you physguntrust.", false )
			ply:PrintChat( "You gave " .. name .. " physguntrust.", false )
		elseif ( args[ 2 ] == "0" ) then
			Target:SetPlayerField( "physguntrust", 0 )
			Target:StripWeapon( "weapon_physgun" )
			Target:PrintChat( ply:Nick() .. " removed your physguntrust", false )
			ply:PrintChat( "You removed '" .. name .. "' physguntrust", false )
		else
			ply:PrintChat( "No player named '" .. name .. "' found.", false )
			return
		end
	end
end
end
concommand.Add( "rp_phystrust", GivePhysgunTrust )

function GiveToolTrust( ply, cmd, args )
	if ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )
	
	if ( Target ) then
		if ( args[ 2 ] == "1" ) then
			Target:SetPlayerField( "tooltrust", 1 )
			Target:Give( "gmod_tool" )
			Target:PrintChat( ply:Nick() .. " gave you tooltrust.", false )
			ply:PrintChat( "You gave " .. name .. " tooltrust.", false )
		elseif ( args[ 2 ] == "0" ) then
			Target:SetPlayerField( "tooltrust", 0 )
			Target:StripWeapon( "gmod_tool" )
			Target:PrintChat( ply:Nick() .. " removed your tooltrust", false )
			ply:PrintChat( "You removed '" .. name .. "' tooltrust", false )
		else
			ply:PrintChat( "No player named '" .. name .. "' found.", false )
			return
		end
	end
end
end
concommand.Add( "rp_tooltrust", GiveToolTrust )

-- Give someone business trust.
function GiveBusinessTrust( ply, cmd, args )
	if ply:Team() == 6 or ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )

	if ( Target ) then
		if ( args[ 2 ] == "1" ) then
			Target:SetCharField( "business", 1 )
			Target:PrintChat( ply:Nick() .. " gave you business trust.", false )
			ply:PrintChat( "You gave " .. name .. " business trust.", false )
		elseif ( args[ 2 ] == "0" ) then
			Target:SetCharField( "business", 0 )
			Target:PrintChat( ply:Nick() .. " removed your business trust", false )
			ply:PrintChat( "You removed '" .. name .. "' business trust", false )
		else
			ply:PrintChat( "No player named '" .. name .. "' found.", false )
			return
		end
		
		umsg.Start( "SendBusinessCheck", Target )
			umsg.Short( PlayerData[ Target:UniqueID() ][ "Characters" ][ Target.CurrentCharID ].business )
		umsg.End()
	end
end
end
concommand.Add( "rp_businesstrust", GiveBusinessTrust )

-- Give someone black market trust.
function GiveBlackMarketTrust( ply, cmd, args )
	if ply:Team() == 6 or ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )

	if ( Target ) then
		if ( args[ 2 ] == "1" ) then
			Target:SetCharField( "BlackMarket", 1 )
			Target:PrintChat( ply:Nick() .. " gave you BlackMarket trust.", false )
			ply:PrintChat( "You gave " .. name .. " BlackMarket trust.", false )
		elseif ( args[ 2 ] == "0" ) then
			Target:SetCharField( "BlackMarket", 0 )
			Target:PrintChat( ply:Nick() .. " removed your BlackMarket trust", false )
			ply:PrintChat( "You removed '" .. name .. "' BlackMarket trust", false )
		else
			ply:PrintChat( "No player named '" .. name .. "' found.", false )
			return
		end
		
		umsg.Start( "SendBlackMarketCheck", Target )
			umsg.Short( PlayerData[ Target:UniqueID() ][ "Characters" ][ Target.CurrentCharID ].BlackMarket )
		umsg.End()
	end
end
end
concommand.Add( "rp_bmtrust", GiveBlackMarketTrust )

function RestartMap( ply, cmd, args )
	if ply:IsAdmin() then
	
	if ( !args[ 1 ] ) then
		ply:PrintChat( "Usage: '!restartmap number(time in seconds)'", false )
		return
	end
	for _, v in pairs( player.GetAll() ) do
		v:PrintChat( ply:Nick() .. " is restarting the map in ".. tonumber( args[ 1 ] ) .. " second( s ).", false )
		timer.Simple( tonumber( args[ 1 ] ), game.ConsoleCommand, "changelevel " .. game.GetMap() .. "\n" )
	end
end
end
concommand.Add( "rp_restartmap", RestartMap )

function SetCombineFlag( ply, cmd, args )
	if ply:IsAdmin() then
	
	local name = args[ 1 ]
	local Target = GetPlayer( name )
	
	if ( Target ) then
		table.insert( Target:GetCharField( "combineflags" ), string.lower( args[ 2 ] ) )
		Target:PrintChat( ply:Nick() .. " Has set your flag to '" .. args[ 2 ] .. "'", false )
		ply:PrintChat( "You set " .. name .. "'s flag to " .. args[ 2 ], false )
	else
		ply:PrintChat( "There is no player named " .. name, false )
		return
	end
end
end
concommand.Add( "rp_setflag", SetCombineFlag )

function ccSpawnItem( ply, cmd, args )
	if ply:IsAdmin() then

	ply:SpawnItem( args[ 1 ] )
	end
end
concommand.Add( "rp_spawnitem", ccSpawnItem )

function SetOOCDelay( ply, cmd, args )
	if ply:IsAdmin() then
	
	Config[ "oocdelay" ] = NilFix( tonumber( args[ 1 ] ), 1 )
end
end
concommand.Add( "rp_oocdelay", SetOOCDelay )