-- The doors table.
Doors = { }

-- Load doors from the txt.
function LoadDoors()
	if ( file.Exists( "Kiwi/Doors/" .. game.GetMap() .. ".txt" ) ) then
		local worked, err = pcall( glon.decode, file.Read( "Kiwi/Doors/" .. game.GetMap() .. ".txt" ) )
		if ( worked ) then
			Doors = err
		else
			return
		end
	else
		return
	end
end

-- Save door info.
function SaveDoors()
	local worked, err = pcall( glon.encode, Doors )
	if ( worked ) then
		file.Write( "Kiwi/Doors/" .. game.GetMap() .. ".txt", err )
	else
		return
	end
end

-- Configure a doors info.
function ConfigureDoor( ply, cmd, args )
	if ply:IsAdmin() then

	local tr = ply:EyeTrace( 80 )
	
	if ( tr.Entity:IsDoor() and tr.Entity:IsValid() ) then
		local NewDoor = { }
		NewDoor.Name = NilFix( args[ 1 ], "" )
		NewDoor.Cost = NilFix( tonumber ( args[ 2 ] ), 0 )
		NewDoor.Owners = NilFix( args[ 3 ], "" )
		NewDoor.Pos = tr.Entity:GetPos()
		
		table.insert( Doors, NewDoor )
		SaveDoors()
	end
end
end
concommand.Add( "rp_newdoor", ConfigureDoor )

-- Buy/Sell doors.
function GM:ShowSpare2( ply )
	local tr = ply:EyeTrace( 80 )
	
	if ( tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		if ( tr.Entity.Owners == nil ) then
			if ( ply:GetNWInt( "Credits" ) >= tr.Entity:GetNWInt( "doorcost" ) ) then
				tr.Entity.Owners = ply
				tr.Entity:SetNWString( "doorname", "Owned by " .. ply:Nick() )
				ply:ConCommand( "settitle" )
				tr.Entity:SetNWBool( "Owned", true )
				ply:TakeCredits( tr.Entity:GetNWInt( "doorcost" ) )
			end
		elseif ( tr.Entity.Owners == ply ) then
			tr.Entity.Owners = nil
			tr.Entity:SetNWBool( "Owned", false )
			tr.Entity:SetNWString( "doorname", "" )
			tr.Entity:Fire( "unlock", "", 0 )
			ply:GiveCredits( tr.Entity:GetNWInt( "doorcost" ) )
		elseif ( tr.Entity.Owners == "Nexus" ) then
			return
		else
			return
		end
	end
end
