function StartSelectCharacter( ply )
	-- Enable mapview.
	ply:SetMapViewEnabled( true )
	ply:SetIntroEnabled( true )
	
	-- StripWeapons.
	ply:StripWeapons()
	
	-- Send the player all the characters avaible.
	ply:SendCharacters()
	
	-- Make the player see the derma menu.
	ply:ConCommand( "charselectframe" )
	-- This is so no one can kill the player.
	ply:KillSilent()
end
concommand.Add( "rp_startselectchar", StartSelectCharacter )

-- Select a character.
function SelectCharacter( ply, cmd, args )
	local ID = tonumber( args[ 1 ] )
	ply.CurrentCharID = tonumber( args[ 1 ] )
	
	if ( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ] != nil ) then
		ply:SetNWString( "RPNick", PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].rpname )
		ply:SetNWInt( "Credits", PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].credits )
		ply:SetCharField( "model", PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].model )
		
		ply:SendCurrentCharInventory()
		
		umsg.Start( "SendBusinessCheck", ply )
			umsg.Short( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].business )
		umsg.End()

		umsg.Start( "SendBlackMarketCheck", ply )
			umsg.Short( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].BlackMarket )
		umsg.End()
		
		ply:SetMapViewEnabled( false )
		ply:SetIntroEnabled( false )
		
		ply.Ready = true
		ply:SetTeam( 1 )
		ply:Spawn()
	end
end
concommand.Add( "rp_selectcharacter", SelectCharacter )

-- Remove a character.
function RemoveCharacter( ply, cmd, args )
	local ID = tonumber( args[ 1 ] )
	
	if ( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ] != nil ) then
		PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ] = nil
	end
end
concommand.Add( "rp_removechar", RemoveCharacter )

function FinishCharCreate( ply, cmd, args )
	local ID = #PlayerData[ ply:UniqueID() ][ "Characters" ] + 1
	ply.CurrentCharID = ID
	
	PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ] = { }
	
	local Chosen = args[ 1 ]
	
	if ( table.HasValue( PlayerModels, Chosen ) ) then
		ply:SetCharField( "model", Chosen )
	end
	
	ply:SetCharField( "rpname", ply:Nick() )

	for fieldname, default in pairs( CharacterDataFields ) do
		if ( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ][ fieldname ] == nil ) then
			PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ][ fieldname ] = ReferenceFix( default )
		end
	end
	
	ply:SetNWInt( "Credits", ply:GetCharField( "credits" ) )

	-- Player is ready.
	ply:SetMapViewEnabled( false )
	ply:SetIntroEnabled( true )
	ply.Ready = true

	umsg.Start( "SendBusinessCheck", ply )
			umsg.Short( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].business )
	umsg.End()	
	
	umsg.Start( "SendBlackMarketCheck", ply )
			umsg.Short( PlayerData[ ply:UniqueID() ][ "Characters" ][ ID ].BlackMarket )
	umsg.End()	

	ply:SendCurrentCharInventory()
	ply:SendCharacters()
	ply:SetTeam( 1 )
	ply:Spawn()
end
concommand.Add( "rp_finishcharcreate", FinishCharCreate )
