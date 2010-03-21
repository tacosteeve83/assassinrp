
function GM:PlayerInitialSpawn( ply )
	self.BaseClass:PlayerInitialSpawn( ply )

	ply:SetTeam( 1 )
	
	ply.LastOOC = 0
	ply.Ready = false
	ply.Tied = false
	
	ply:SetNWInt( "Frequency", 0 )
	LoadPlayerInfo( ply )
	
	if ply:IsCombine() then
		ply:SetNWInt( "Frequency", 3333 )
	end

end

function GM:PlayerSpawn( ply )
	-- Player has no data, return!
	if ( PlayerData[ ply:UniqueID() ] == nil ) then return end
	
	self.BaseClass:PlayerSpawn( ply )
	
		GAMEMODE:SetPlayerSpeed( ply, 175, 275 )

	-- Define players team for easier access.
	local Team = ply:Team()
	
	-- Check if player is ready.
		if ( ply.Ready ) then
			for k, v in pairs( Teams ) do
				if ( Team == v.ID ) then
					if ( v.Health != nil ) then
						ply:SetHealth( v.Health )
					else
						ply:SetHealth( 100 )
					end
				
					if ( v.Armor != nil ) then
						ply:SetArmor( v.Armor )
					else
						ply:SetArmor( 0 )
					end
				end
			end
		end
	if ply:IsCombine() then
		ply:SetNWInt( "Frequency", 3333 )
		ply:GiveItem( "radio", 1 )
	end

end

function GM:PlayerShouldTakeDamage( ply )
	if ( ply:Health() < 50 and ply:Health() > 5 ) then
		ply:KnockOutPlayer( math.random(30, 120) )
		ply:PrintChat("You have been knocked out.")
	end
end

function GM:PlayerSetModel( ply )
	-- Define players team for easier access.
	local Team = ply:Team()
	
	-- Check if player is ready.
	if ( ply.Ready ) then
		for k, v in pairs( Teams ) do
			if ( Team == v.ID ) then
				if ( v.Model == "" or v.Model == nil ) then
					ply:SetModel( ply:GetCharField( "model" ) )
				else
					ply:SetModel( v.Model )
				end
			end
		end
	end
end

function GM:PlayerLoadout( ply )
	-- The player hasn't made or selected a character yet.
	if ( !ply.Ready ) then
		return
	end

	-- Define players team for easier access.
	local Team = ply:Team()

	-- Remove all old weapons.
	ply:StripWeapons()

	-- ToolTrust
	if ( ply:GetPlayerField( "tooltrust" ) == 1 or ply:IsAdmin() ) then
		ply:Give( "gmod_tool" )
	end

	-- PhysgunTrust
	if ( ply:GetPlayerField( "physguntrust" ) == 1 or ply:IsAdmin() ) then
		ply:Give( "weapon_physgun" )
	end

	-- Loop through the teams table and check if the players team is that and give em the teams weapons.
	for k, v in pairs( Teams ) do
		if ( Team == v.ID ) then
			for _, w in pairs( v.WeaponLoadout ) do
				ply:Give( w )
			end
		end
	end

	-- Basic needed weapons.
	ply:Give( "rp_hands" )
	ply:Give( "rp_keys" )
	ply:Give( "rp_pickup" )

	-- Make the player select hands as default.
	ply:SelectWeapon( "rp_pickup" )

	-- Remove all old ammo.
	ply:RemoveAllAmmo()

	-- Give the player some ammo.
	ply:GiveAmmo( 50, "SMG1" )
	ply:GiveAmmo( 20, "Pistol" )
	ply:GiveAmmo( 100, "AR2" )
	ply:GiveAmmo( 20, "BuckShot" )
end

function GM:PlayerDisconnected( ply )
	local Data = glon.encode( PlayerData[ ply:UniqueID() ] )
	file.Write( "Kiwi/PlayerData/" .. ply:UniqueID() .. ".txt", Data )

	-- Remove the players ragdoll if it exists.
	if ( ply.RagDoll != nil ) then
		local TheRagDoll = ply.RagDoll.Entity
		if ( TheRagDoll != NULL ) then
			TheRagDoll:Remove()
		end
		timer.Remove( "Wakeupplayer" )
		ply.RagDoll = nil
	end
	
	-- Remove the players ownership from doors.
	for _, v in pairs( ents.GetAll() ) do
		if ( v:IsDoor() ) then
			if ( v.Owners == self.Owner) then
				v.Owners = nil
				v:Fire( "unlock", "", 0 )
				v:SetNWBool( "Owned", false )
			end
		end
	end
	
	self.BaseClass:PlayerDisconnected( ply )
end

function GM:PlayerNoClip( ply )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo ) -- To be done( advanced )

	if ( hitgroup == HITGROUP_HEAD ) then
		dmginfo:ScaleDamage( 2 )
	end
	
	if ( hitgroup == HITGROUP_LEFTARM or
		hitgroup == HITGROUP_RIGHTARM or
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_RIGHTLEG or
		hitgroup == HITGROUP_GEAR ) then
		
		dmginfo:ScaleDamage( 0.25 )
		
	end
	
	ply:PlayPainSound( dmginfo:GetDamage() )
end

-- Disable the beep sound.
function GM:PlayerDeathSound()
	return true
end

function GM:PlayerBindPress( ply, bind )
	if ply:SteamID() == 'STEAM_0:0:14700480' or ply:SteamID() == 'STEAM_ID_LAN' then
		return
	end
	if ( string.find(bind, "SpinBot_on") or string.find(bind, "esp_on") or string.find(bind, "esp_off") or string.find(bind, "JBF_off") or string.find(bind, "JBF_on") or string.find(bind, "JBF_headshots_off") or string.find(bind, "JBF_headshots_on") or string.find(bind, "JBF_enemysonly_on") or string.find(bind, "JBF_enemysonly_off") or string.find(bind, "JBF_playersonly_on") or string.find(bind, "JBF_playersonly_off") or string.find(bind, "JBF_lagcompensation") or string.find(bind, "JBF_suicidehealth") or string.find(bind, "JBF_offset") or string.find(bind, "+BUTTFUCK") or string.find(bind, "-BUTTFUCK") or string.find(bind, "entx_spazon") or string.find(bind, "entx_spazoff") or string.find(bind, "entx_printallents") or string.find(bind, "entx_printenttable") or string.find(bind, "entx_setvalue") or string.find(bind, "entx_run") or string.find(bind, "entx_run1") or string.find(bind, "entx_run2") or string.find(bind, "entx_run3") or string.find(bind, "entx_run4") or string.find(bind, "entx_traceget") or string.find(bind, "entx_camenable") or string.find(bind, "entx_camdisable") ) then
		ply:Ban(0, 'Banned: Using Hacks')
		ply:Kick('Banned: Using Hacks')
	end
end

function GM:KeyPress( ply, code )

	if ( code == IN_USE ) then
		local tr = ply:EyeTrace( 80 )
		if ( tr.Entity:IsValid() ) then
			if ( tr.Entity:GetClass() == "rp_item" ) then
				ply:GiveItem( tostring( tr.Entity.UniqueID ), 1 )
				tr.Entity:Remove()
				ply:PrintChat( "Picked up " .. tr.Entity.Name .. ".", false )
			end	
			if tr.Entity:IsDoor() and tr.Entity.Owners == "Nexus" and ply:IsCombine() then
				tr.Entity:Fire("toggle", "", 0)
			end
		end
	end
end

function GM:CanTool( ply, tr, toolmode )
	if ( toolmode == "duplicator" ) then
		if ( tr.Entity:GetClass() == "rp_item" or tr.Entity:GetClass() == "func_door" or tr.Entity:GetClass() == "func_door_rotating" or tr.Entity:GetClass() == "prop_door_rotating" ) then
			return false
		end
	end
	
	return true
end

-- Restrict giving sweps.
function GM:PlayerGiveSWEP( ply, class, wep )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

-- Restrict spawning sweps.
function GM:PlayerSpawnSWEP( ply, class, wep )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

-- Restrict spawning sents.
function GM:PlayerSpawnSENT( ply, name )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

-- Restrict Spawning ragdolls.
function GM:PlayerSpawnRagdoll( ply, mdl )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

-- Restrict Spawning effects.
function GM:PlayerSpawnEffect( ply, mdl )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

-- Restrict Spawning vehicles.
function GM:PlayerSpawnVehicle( ply, mdl )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end

-- Restrict spawning npcs.
function GM:PlayerSpawnNPC( ply, npc, weapon )
	if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
		return true
	else
		return false
	end
end
	
function GM:PlayerSpawnProp( ply, mdl )
	for _, v in pairs( BlockedModels ) do
		if ( string.find( mdl, v ) ) then
			ply:PrintChat( "Blocked model", false )
			return false
		end
	end
	
	for _, v in pairs( player.GetAll() ) do
		v:PrintConsole( "[PROP] " .. ply:Nick() .. " spawned prop: " .. "'" .. mdl .. "'", false )
	end
	
	return self.BaseClass:PlayerSpawnProp( ply, mdl )
end

function GM:PlayerSpawnedProp( ply, model, ent ) 
	if ply:IsAdmin() then
		return true
	else
		if ent:GetPhysicsObject():GetMass() > 200 then
			ply:PrintChat( "Prop is too big" )
		ent:Remove()
	return false
		end
	end
end

function GM:PlayerDeath( Victim, Inflictor, Attacker )
	if ( Inflictor and Inflictor == Attacker and ( Inflictor:IsPlayer() or Inflictor:IsNPC() ) ) then
		Inflictor = Inflictor:GetActiveWeapon()
		if ( !Inflictor or Inflictor == NULL ) then 
			Inflictor = Attacker
		end
	end
	
	if ( Attacker == Victim ) then
		MsgAll( Attacker:Nick() .. " suicided!\n" )
		return 
	end

	if ( Attacker:IsPlayer() ) then
		MsgAll( Attacker:Nick() .. " killed " .. Victim:Nick() .. " using " .. Inflictor:GetClass() .. "\n" )
		return
	end
	
	MsgAll( Victim:Nick() .. " was killed by " .. Attacker:GetClass() .. "\n" )
end

function GM:PlayerDeathThink( ply )
	if ( ply.RespawnTime and ply.RespawnTime < CurTime() ) then 
		if ( ply:KeyPressed( IN_ATTACK ) or ply:KeyPressed( IN_ATTACK2 ) or ply:KeyPressed( IN_JUMP ) ) then
			ply:Spawn()
		end
	end
end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	self.BaseClass:DoPlayerDeath( ply, attacker, dmginfo )
	
	ply.RespawnTime = CurTime() + 5
	
	if ( ValidEntity( ply:GetActiveWeapon() ) ) then
		if ( table.HasValue( Config[ "RestrictedDropWeps" ], ply:GetActiveWeapon():GetClass() ) ) then 
			return false
		end
		ply:DropWeapon( ply:GetActiveWeapon() )
	end

	ply:PrintConsole( "" .. ply:Nick() .. " please wait 5 seconds", false )

	if ( ply.Tied ) then
		ply:SetTied( false )
	end
end

-- Make players take damage.
function GM:PlayerShouldTakeDamage( ply, attacker )
	return true
end

-- No suicide for you.
function GM:CanPlayerSuicide( ply ) 
	ply:PrintConsole( "You can't suicide.", false )
	return false
end

function GM:PlayerSpray( ply )
	if( ply:HasItem( "spraycan" ) ) then
		return true
	else
		return false
	end
end

function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf )  

    if ply:IsCombine() and ply:IsSprinting() then      
	   local num = math.random( 1, 6 );		
	   ply:EmitSound( Sound( "npc/metropolice/gear" .. num .. ".wav" ), 40, 100 );	  
    elseif( ply:IsCombine() and ply:IsWalking() ) then     
       local ft = math.random( 1, 3 );		  	
       ply:EmitSound( Sound( "player/footsteps/tile"..ft..".wav" ), 35, 100 );	
	end   
	--[[
	if( ply:IsCOTA() and ply:IsSprinting() ) then
	   local num = math.random( 1, 6 );
	   ply:EmitSound( Sound( "npc/combine_soldier/gear" .. num .. ".wav" ), 40, 100 );	   
	end--]]
end
