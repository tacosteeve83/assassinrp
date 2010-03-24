require( "datastream" )
require( "glon" )

AddCSLuaFile( "vgui/cl_playermenu.lua" )
AddCSLuaFile( "vgui/cl_charcreatemenu.lua" )
AddCSLuaFile( "vgui/cl_radiomenu.lua" )
AddCSLuaFile( "vgui/cl_selectcharmenu.lua" )
AddCSLuaFile( "vgui/cl_dermaskin.lua" )
AddCSLuaFile( "vgui/cl_books.lua" )
AddCSLuaFile( "teams.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "entity_shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_networking.lua" )
AddCSLuaFile( "player_shared.lua" )
AddCSLuaFile( "daynight.lua" )

include( "teams.lua" )
include( "shared.lua" )
include( "concmds.lua" )
include( "eng_concmds.lua" )
include( "config.lua" )
include( "server_util.lua" )
include( "player_hooks.lua" )
include( "player_shared.lua" )
include( "player_util.lua" )
include( "player_data.lua" )
include( "chat.lua" )
include( "admincc.lua" )
include( "resources.lua" )
include( "doors.lua" )
include( "animations.lua" )
include( "charactercreate.lua" )
include( "entity_shared.lua" )
include( "daynight.lua" )
include( "combinevoices.lua" )

-- Send the client all items.
for k, v in pairs( file.FindInLua( "Kiwi/gamemode/items/*.lua" ) ) do AddCSLuaFile( "items/" .. v ) end

function GM:Initialize()
	self.BaseClass:Initialize()
	
	SetGlobalInt( "RationSupply", 30 )
	
	timer.Create( "RationSupplyIncrease", 300, 0, function()
		SetGlobalInt( "RationSupply", 30 )
	end )

	LoadDoors()

	umsg.PoolString( "GiveItem" )
	umsg.PoolString( "RemoveItem" )
	umsg.PoolString( "SendCharacters" )
end

function GM:InitPostEntity( )
	self.BaseClass:InitPostEntity()
	
	RunConsoleCommand( "sbox_godmode", "0" )
	RunConsoleCommand( "sbox_plpldamage", "0" )
	
	for k, v in pairs( Doors ) do
		for k2, v2 in pairs( ents.FindInSphere( v.Pos, 0.1 )  ) do
			if ( v2:IsDoor() ) then
				if ( v2:GetPos() == v.Pos ) then
					v2:SetNWString( "doorname", v.Name )
					v2:SetNWInt( "doorcost", 50 )
					
					if ( v.Owners != "" ) then
						v2.Owners = v.Owners
					end
					
					if ( v2.Owners == "Nexus" ) then
						v2:SetNWBool( "Owned", true )
					end
				end
			end
		end
	end
end

function GM:ShutDown(ply)
	self.BaseClass:ShutDown()

	for _, v in pairs( player.GetAll() ) do
		SavePlayerInfo( v )
	end
end

function GM:PlayerDisconnected(ply)
	SavePlayerInfo( ply )
end

function GM:ShowHelp( ply )
	umsg.Start('playermenu', ply);
	umsg.End();
end

function GM:ShowTeam( ply )
	if ply:IsWM() then
		umsg.Start('cwu', ply);
		umsg.End();
	elseif ply:IsCombine() then
		umsg.Start('uu', ply);
		umsg.End();
	else
		ply:PrintChat( "You dont have access")	
	end
end

function GM:ShowSpare1( ply )
	ply:ConCommand( "charselectframe" )
end

function GM:PhysgunPickup( ply, Ent )
	if ( Ent:GetClass() == "player" ) then
		if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
			return true
		else
			return false
		end
	end

	if ( string.find( Ent:GetClass(), "npc_" ) or string.find( Ent:GetClass(), "prop_dynamic" ) or string.find( Ent:GetClass(), "func_" ) ) then
		if ( !ply:IsSuperAdmin() ) then
			return false
		end
	end
	
	return self.BaseClass:PhysgunPickup( ply, Ent )
end

function GM:GravGunPunt( ply, target )
	return false
end

function GM:GetFallDamage( ply, flFallSpeed )
	return math.random( 10, 40 )
end

function GM:Think()
end

--function GM:Tick()
--	for _, ply in pairs( player.GetAll() ) do
--			ply:SetWalkSpeed( Config[ "WalkSpeed" ] )
--			ply:SetRunSpeed( Config[ "RunSpeed" ] )
--	end
--end

-- Don't allow the client to send datastreams to the server.
function GM:AcceptStream( ply, handler, id )
	return false
end

-- Fix for gamemode name.
require( "gamedescription" )
function GM:GetGameDescription()
	return self.Name
end

COMBINE_WALK = {
"npc/metropolice/gear1.wav",
"npc/metropolice/gear2.wav",
"npc/metropolice/gear3.wav",
"npc/metropolice/gear4.wav",
"npc/metropolice/gear5.wav",
"npc/metropolice/gear6.wav"
}