-- Set your Roleplay Nick.
function SetRPNick( ply, cmd, args )
	ply:SetCharField( "rpname", table.concat( args, " " ) )
	ply:SetNWString( "RPNick", table.concat( args, " " ) )
end
concommand.Add( "rp_rpnick", SetRPNick )

-- Save your stuff manually.
function SaveManual( ply )
	local Data = glon.encode( PlayerData[ ply:UniqueID() ] )
	file.Write( "Kiwi/PlayerData/" .. ply:UniqueID() .. ".txt", Data )
end
concommand.Add( "rp_savemanual", SaveManual )

-- Give the one you're looking at credits.
function GiveMoney( ply, cmd, args )
	local tr = ply:EyeTrace( 90 )

	if ( ply:GetNWInt( "Credits" ) > tonumber( args[ 1 ] ) ) then
		if ( ValidEntity( tr.Entity ) and tr.Entity:IsPlayer() ) then
			tr.Entity:GiveCredits( math.floor( args[ 1 ] ) )
			tr.Entity:PrintChat( "You have recieved " .. math.floor( args[ 1 ] ) .. " credits from " .. ply:Nick(), false )
			ply:TakeCredits( math.floor( args[ 1 ] ) )
			ply:PrintChat( "You gave " .. tr.Entity:Nick() .. " " .. math.floor( args[ 1 ] ) .. " credits", false )
		end
	end
end
concommand.Add( "rp_givemoney", GiveMoney )

-- Change your radio frequency.
function ChangeFrequency( ply, cmd, args )
	ply:SetNWInt( "Frequency", tonumber( args[ 1 ] ) )
	ply:PrintChat( "You changed radio channel to " .. tonumber( args[ 1 ] ) )
end
concommand.Add( "rp_changefrequency", ChangeFrequency )

-- Drop your weapon.
function DropWeapon( ply )
	ply:GetActiveWeapon()
	ply:DropWeapon()
end
concommand.Add( "rp_dropweapon", DropWeapon )

-- Hello basic heres your model. Shitty coding.
function Female( ply )
	if ply:Team() == 5 then
		ply:SetModel("models/police_female.mdl")
		ply:PrintChat( "Your model has been set to " .. ply:GetModel() .. "!", false )
	else
		ply:PrintChat( "Your not the RIGHT role." , false)
	end
end
concommand.Add( "rp_cca1", Female )

-- Did someone say new city admin model? Shitty coding.
function CityAdmin( ply )
	if ply:Team() == 10 then
		ply:SetModel("models/humans/group01/drconnors.mdl")
		ply:PrintChat( "Your model has been set to " .. ply:GetModel() .. "!", false )
	else
		ply:PrintChat( "Your not the RIGHT role." , false)
	end
end
concommand.Add( "rp_ca_model1", CityAdmin )

-- Did someone say new city admin model? Shitty coding.
function CityAdmin2( ply )
	if ply:Team() == 10 then
		ply:SetModel("models/characters/gallaha.mdl")
		ply:PrintChat( "Your model has been set to " .. ply:GetModel() .. "!", false )
	else
		ply:PrintChat( "Your not the RIGHT role." , false)
	end
end
concommand.Add( "rp_ca_model2", CityAdmin2 )

-- Hide your weapon in your inventory?
function PutWeaponInInventory( ply )
		local Weapon = ply:GetActiveWeapon():GetClass()
		for _, v in pairs( Items ) do	
			if ( v.UniqueID == Weapon ) then
				ply:StripWeapon( Weapon )
				ply:GiveItem( Weapon, 1 )
		end
	end
end
concommand.Add( "rp_storewep", PutWeaponInInventory )

-- Set a doors name.
function SetDoorName( ply, cmd, args )
	local tr = ply:EyeTrace( 90 )
	
	if ( tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		if ( tr.Entity.Owners == ply ) then
			tr.Entity:SetNWString( "doorname", table.concat( args, " " ) )
		else
			return
		end
	end
end
concommand.Add( "rp_doorname", SetDoorName )
concommand.Add( "rp_doortitle", SetDoorName )

function Flag( ply, cmd, args )
	for k, v in pairs( Teams ) do
		if ( tostring( v.Flag ) == args[ 1 ] ) then
			if ( v.Flag != nil ) then
				if ( ply:HasCombineFlag( args[ 1 ] ) or v.Flag == "c" ) then
					ply:SetTeam( v.ID )
					ply:Spawn()
				else
					ply:SetTeam( v.ID )
					ply:Spawn()
					return
				end
			end
		end
	end
end
concommand.Add( "rp_flag", Flag )

-- Combine ration spawning.
function CombineRationDistribution( ply, cmd, args )
	if ( GetGlobalInt( "RationSupply" ) <= 0 ) then
		ply:PrintChat( "Ration supply is empty, please wait for the new supply to arrive.", false )
		return
	end
	
	if ( ply:IsCombine() ) then
		SetGlobalInt( "RationSupply", math.Clamp( GetGlobalInt( "RationSupply" ) - 1, 0, 30 ) )
			ply:SpawnItem( "r09239830428" )
		for _, v in pairs( player.GetAll() ) do
			v:PrintConsole( ply:Nick() .. " spawned ration ", false )
		end
	end
end
concommand.Add( "combinerationspawning", CombineRationDistribution )

function ccCPPlay( ply, cmd, args )
    if ply:IsCombine() then

	if( #args < 1 ) then return; end
	local n = tonumber( args[1] );
	if( n == nil ) then
		ply:PrintMessage( 2, "Invalid. Use sound ID" );
		return;
	end
	if( not TS.CPDispatchSounds[n] ) then
		ply:PrintMessage( 2, "Sound doesn't exist" );
		return;
	end
	util.PrecacheSound( TS.CPDispatchSounds[n].dir );
	for k, v in pairs( player.GetAll() ) do
	    if( v:IsCombine() ) then
	        v:EmitSound( TS.CPDispatchSounds[n].dir );
				    ply:ConCommand( "say /rd " .. TS.CPDispatchSounds[n].line )
                end
	      end
     end
end
concommand.Add( "emit_dispatch", ccCPPlay );
concommand.Add( "rp_emit", ccCPPlay );