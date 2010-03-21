local MalePainSounds = 
{
	Sound( "vo/npc/male01/ow01.wav" ),
	Sound( "vo/npc/male01/ow02.wav" ),
	Sound( "vo/npc/male01/pain01.wav" ),
	Sound( "vo/npc/male01/pain02.wav" ),
	Sound( "vo/npc/male01/pain03.wav" ),
	Sound( "vo/npc/male01/pain04.wav" ),
	Sound( "vo/npc/male01/pain05.wav" ),
	Sound( "vo/npc/male01/pain06.wav" ),
	Sound( "vo/npc/male01/pain07.wav" ),
	Sound( "vo/npc/male01/pain08.wav" ),
	Sound( "vo/npc/male01/pain09.wav" )
}

local FemalePainSounds =
{
	Sound( "vo/npc/female01/ow01.wav" ),
	Sound( "vo/npc/female01/ow02.wav" ),
	Sound( "vo/npc/female01/pain01.wav" ),
	Sound( "vo/npc/female01/pain02.wav" ),
	Sound( "vo/npc/female01/pain03.wav" ),
	Sound( "vo/npc/female01/pain04.wav" ),
	Sound( "vo/npc/female01/pain05.wav" ),
	Sound( "vo/npc/female01/pain06.wav" ),
	Sound( "vo/npc/female01/pain07.wav" ),
	Sound( "vo/npc/female01/pain08.wav" ),
	Sound( "vo/npc/female01/pain09.wav" )
}

local PMeta = FindMetaTable( "Player" )

-- Knockout/ragdoll function.
function PMeta:KnockOutPlayer( seconds )
	self.Weapons = { }
	self.RagDoll = { }
	
	local KnockOutRagDoll = ents.Create( "prop_ragdoll" )
	KnockOutRagDoll:SetModel( self:GetModel() )
	KnockOutRagDoll:SetPos( self:GetPos() )
	KnockOutRagDoll:SetAngles( self:GetAngles() )
	KnockOutRagDoll:Spawn()
	KnockOutRagDoll:Activate()

	for k, v in pairs( self:GetWeapons() ) do
		table.insert( self.Weapons, v:GetClass() )
	end
	
	self:StripWeapons()
	self:SpectateEntity( KnockOutRagDoll )
	self:Spectate( OBS_MODE_CHASE )
	self.RagDoll.Entity = KnockOutRagDoll
	
	timer.Create( "Wakeupplayer", seconds, 1, function() 
		local TheRagDoll = self.RagDoll.Entity
		
		self:Spawn()
		self:SetPos( TheRagDoll:GetPos() + Vector( 0, 0, 32 ) )
		
		for k, v in pairs( self.Weapons ) do
			self:Give( v )
			self.Weapons = nil
		end
		
		if ( TheRagDoll != NULL ) then
			TheRagDoll:Remove()
		end
		
		self.RagDoll = nil
	end )
end

-- Play painsounds when player gets hurt.
function PMeta:PlayPainSound()
	self.NextPainSound = self.NextPainSound or CurTime()
	if ( CurTime() < self.NextPainSound ) then return end

	self.NextPainSound = CurTime() + 0.2

	if ( self:Alive() ) then
		if ( string.find( string.lower( self:GetModel() ), "female" ) ) then
			self:EmitSound( FemalePainSounds[ math.random( 1, #FemalePainSounds ) ] )
		elseif ( string.find( string.lower( self:GetModel() ), "male" ) ) then
			self:EmitSound( MalePainSounds[ math.random( 1, #MalePainSounds ) ] )
		end
	end
end

-- Increase a players credits.
function PMeta:GiveCredits( amt, ply ) 
	if ( amt < 0 ) then return end
	
	self:SetNWInt( "Credits", self:GetNWInt( "Credits" ) + amt )
	self:SetCharField( "credits", self:GetCharField( "credits" ) + amt )
	
end

-- Increase a players credits.
function PMeta:AddCredits( amt, ply ) 
	if ( amt < 0 ) then return end
	
	self:SetNWInt( "Credits", self:GetNWInt( "Credits" ) + amt )
	self:SetCharField( "credits", self:GetCharField( "credits" ) + amt )
	
end

-- Decrease a players credits.
function PMeta:TakeCredits( amt, ply )
	if ( amt < 0 ) then return end
	
	self:SetNWInt( "Credits", math.Clamp( self:GetNWInt( "Credits" ) - amt, 0, self:GetNWInt( "Credits" ) ) )
	self:SetCharField( "credits", math.Clamp( self:GetCharField( "credits" ) - amt, 0, self:GetCharField( "credits" ) ) )
	
end

-- Clean the players inventory.
function PMeta:CleanInventory()
	umsg.Start( "CleanInventory", self )
	umsg.End()
end

-- Send the players current inventory fully.
function PMeta:SendCurrentCharInventory()
	self:CleanInventory()
	
	for k, v in pairs( self:GetCurrentCharInventory() ) do
		local ItemsToSend = { UniqueID = k, Amount = v }
		datastream.StreamToClients( self, "SendCurrentCharInventory", ItemsToSend )
	end
end

-- Insert a item to the players inventory.
function PMeta:GiveItem( item, amount )
	if ( amount != 0 ) then
		if ( self:GetCurrentCharInventory()[ item ] ) then
			self:GetCurrentCharInventory()[ item ] = self:GetCurrentCharInventory()[ item ] + amount
		else
			self:GetCurrentCharInventory()[ item ] = 0
			self:GetCurrentCharInventory()[ item ] = self:GetCurrentCharInventory()[ item ] + amount
		end
	end

	umsg.Start( "GiveItem", self )
		umsg.String( tostring( item ) )
		
		if ( amount != 0 ) then
			umsg.Long( amount )
		end
		
	umsg.End()
end

-- Remove a item from the players inventory.
function PMeta:RemoveItem( item, amount )
	if ( amount != 0 ) then
		self:GetCurrentCharInventory()[ item ] = self:GetCurrentCharInventory()[ item ] - amount
	end
	
	if ( self:GetCurrentCharInventory()[ item ] == 0 ) then
		self:GetCurrentCharInventory()[ item ] = nil
	end
	
	umsg.Start( "RemoveItem", self )
		umsg.String( tostring( item ) )
		
		if ( amount != 0 ) then
			umsg.Long( amount )
		end
		
	umsg.End()
end

-- Check if the player has a item.
function PMeta:HasItem( item )
	for k, amount in pairs( self:GetCurrentCharInventory() ) do
		if ( k == item ) then
			if ( amount >= 1 ) then
				return true
			else
				return false
			end
		end
	end
end

-- Check if the player has the combine flag.
function PMeta:HasCombineFlag( flag )
	if ( table.HasValue( self:GetCharField( "combineflags" ), tostring( flag ) ) ) then
		return true
	else
		return false
	end
end

-- Clean the character table.
function PMeta:CleanCharacterTable()
	umsg.Start( "CleanCharacterTable", self )
	umsg.End()
end

-- Send all the players characters.
function PMeta:SendCharacters()
	self:CleanCharacterTable()
	
	local CharTable = PlayerData[ self:UniqueID() ][ "Characters" ]
	for k, v in pairs( CharTable  ) do
		umsg.Start( "SendCharacters", self )
			umsg.Short( k )
			umsg.String( v[ "rpname" ] )
			umsg.String( v[ "model" ] )
		umsg.End()
	end
end

function PMeta:GetCurrentCharInventory()
	return self:GetCharField( "inventory" )
end

-- Spawn a item.
function PMeta:SpawnItem( ID )
	if( Items[ ID ] == nil ) then 
		self:PrintChat( "Item class doesn't exist.", true ) 
		return 
	end
	
	local tr = self:EyeTrace( 30 )
	
	local item = ents.Create( "rp_item" )
	item:SetModel( Items[ ID ].Model )
	item:SetAngles( Angle( 0, 0, 0 ) )
	item:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
	
	for k, v in pairs( Items[ ID ] ) do
		item[ k ] = v
		if ( type( v ) == "string" ) then
			item:SetNWString( k, v )
		end
	end
	
	item:Spawn( )
	item:Activate( )
end

-- Quick, good looking function.
function PMeta:SetMapViewEnabled( bool )
	umsg.Start( "MapViewEnabled", self )
		umsg.Bool( bool )
	umsg.End()
end

-- Quick, good looking Intro function.
function PMeta:SetIntroEnabled( bool )
	umsg.Start( "IntroEnabled", self )
		umsg.Bool( bool )
	umsg.End()
end

-- Set a players tied status.
function PMeta:SetTied( tied )
	self.Tied = tied
	
	umsg.Start( "SendTied", self )
		umsg.Bool( tied )
	umsg.End()
end

-- IC Grammar check.
function PMeta:CheckGrammar( Text )
    local RetText = " " .. string.lower( Text ) .. " "

    --for K, V in pairs( FilterWords ) do
		--RetText = string.Replace( RetText, " " .. K .. " ", " " .. V .. " " )
	--end

    RetText = string.Trim( RetText )
    local UpperText = string.upper( string.sub( RetText, 0, 1 ) )
    RetText = UpperText .. "" .. string.sub( RetText, 2, string.len( RetText ) )
	
    if ( !string.find( string.sub( RetText, string.len( RetText ) ), "%p" ) ) then
        RetText = RetText .. "."
    end
    return RetText
end

-- Send chattext to the client.
function PMeta:SendChatText( ... )
	umsg.Start( "SendChatText", self ) 
	umsg.Short( #arg )
		local colour = true
		for k, v in ipairs( arg ) do
			if ( colour ) then
				local vec = Vector( v.r, v.g, v.b )
				umsg.Vector( vec )
			else
				umsg.String( v )
			end
			colour = !colour
		end
	umsg.End()
end

PMeta = nil
