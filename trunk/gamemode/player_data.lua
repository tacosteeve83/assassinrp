-- Global saving table.
PlayerData = { }

-- Global saving table.
AccountData = { }

-- Flags and stuff that's not needed each character.
PlayerDataFields = { }

-- Table for each character.
CharacterDataFields = { }

function AddDataField( fieldtype, fieldname, default )
	if ( fieldtype == 1 ) then
		PlayerDataFields[ fieldname ] = ReferenceFix( default )
	elseif ( fieldtype == 2 ) then
		CharacterDataFields[ fieldname ] = ReferenceFix( default )
	end
end

AddDataField( 1, "Characters", { } )
AddDataField( 1, "tooltrust", 0 )
AddDataField( 1, "physguntrust", 0 )
AddDataField( 2, "model", "models/kleiner.mdl" )
AddDataField( 2, "rpname", "" )
AddDataField( 2, "business", 1 )
AddDataField( 2, "BlackMarket", 0 )
AddDataField( 2, "credits", 1500 )
AddDataField( 2, "inventory", { } )
AddDataField( 2, "combineflags", { } )

function LoadPlayerInfo( ply )
	local ID = ply:UniqueID()
	
	PlayerData[ ID ] = { }
	
	if ( file.Exists( "Kiwi/PlayerData/" .. ply:UniqueID() .. ".txt" ) ) then
			local Data_Raw = file.Read( "Kiwi/PlayerData/" .. ply:UniqueID() .. ".txt" )
			
			local Data_Table = NilFix( glon.decode( Data_Raw ), { } )
			
			PlayerData[ ID ] = Data_Table
			
			local PlayerTable = PlayerData[ ID ]
			local CharacterTable = PlayerData[ ID ][ "Characters" ]
			
			for k, v in pairs( PlayerTable ) do
				if ( PlayerDataFields[ k ] == nil ) then
					PlayerData[ ID ][ k ] = nil
				end
			end
			
			for fieldname, default in pairs( PlayerDataFields ) do
				if ( PlayerTable[ fieldname ] == nil ) then
					PlayerData[ ID ][ fieldname ] = ReferenceFix( default )
				end
			end
			
			for key, char in pairs( CharacterTable ) do
				for k, v in pairs( char ) do
					if ( CharacterDataFields[ k ] == nil ) then
						PlayerData[ ID ][ "Characters" ][ key ][ k ] = nil
					end
				end
			end
			
			for key, char in pairs( CharacterTable ) do
				for fieldname, default in pairs( CharacterDataFields ) do
					if ( char[ fieldname ] == nil ) then
						PlayerData[ ID ][ "Characters" ][ key ][ fieldname ] = ReferenceFix( default )
					end
				end
			end
			
		SavePlayerInfo( ply )
		ply:ConCommand( "rp_startselectchar" )
		print( "Loaded data for player: " .. ply:Name() )
	else
		PlayerData[ ID ] = { }
		
		for fieldname, default in pairs( PlayerDataFields ) do
			if ( PlayerData[ fieldname ] == nil ) then
				PlayerData[ ID ][ fieldname ] = ReferenceFix( default )
			end
		end
		
		SavePlayerInfo( ply )
		ply:ConCommand( "charcreatemenu" )
	end
end

function SavePlayerInfo( ply )
	local Data = glon.encode( PlayerData[ ply:UniqueID() ] )
	file.Write( "Kiwi/PlayerData/" .. ply:UniqueID() .. ".txt", Data )
end

local PMeta = FindMetaTable( "Player" )

function PMeta:SetPlayerField( fieldname, data )
	if ( PlayerDataFields[ fieldname ] ) then
		PlayerData[ self:UniqueID() ][ fieldname ] = data
	else
		return ""
	end
end

function PMeta:GetPlayerField( fieldname )
	if ( PlayerDataFields[ fieldname ] ) then
		return PlayerData[ self:UniqueID() ][ fieldname ]
	else
		return ""
	end
end

function PMeta:SetCharField( fieldname, data )
	if ( CharacterDataFields[ fieldname ] ) then
		PlayerData[ self:UniqueID() ][ "Characters" ][ self.CurrentCharID ][ fieldname ] = data
		SavePlayerInfo( self )
	else
		return ""
	end
end

function PMeta:GetCharField( fieldname )
	if ( CharacterDataFields[ fieldname ] ) then
		return PlayerData[ self:UniqueID() ][ "Characters" ][ self.CurrentCharID ][ fieldname ]
	else
		return ""
	end
end

 --- Get the players inventory weight (The collected weight of all things in the players inventory)
function PMeta:GetInventoryWeight ( )
	local Weight = 0;
	
	for k, v in pairs(self:GetCurrentCharInventory()) do
		if Items[ k ].Weight then
			Weight = Weight + (Items[ k ].Weight * v);
		else
			print( 'ERROR: Missing item info for ' .. ply:Name() )
		end
	end
	
	return Weight;
end

--- How much can the player carry?
function PMeta:GetMaximumInventoryWeight ( )
	return Config[ 'maxweight' ]
end

PMeta = nil
