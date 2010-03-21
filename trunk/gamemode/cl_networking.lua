require( "datastream" )

datastream.Hook( "SendCurrentCharInventory", function( id, handler, enc, dec )
	local ID = dec.UniqueID
	local Num = dec.Amount

	Inventory[ ID ] = 0
	
	if ( Inventory[ ID ] ) then
		Inventory[ ID ] = Inventory[ ID ] + Num
	end
end )

usermessage.Hook( "GiveItem", function( um )
	local ID = um:ReadString()
	local Num = um:ReadLong()
	
	if ( Inventory[ ID ] ) then
		Inventory[ ID ] = Inventory[ ID ] + Num
	else
		Inventory[ ID ] = 0
		Inventory[ ID ] = Inventory[ ID ] + Num
	end
end )

usermessage.Hook( "RemoveItem", function( um )
	local ID = um:ReadString()
	local Num = um:ReadLong()

	if ( Inventory[ ID ] ) then
		Inventory[ ID ] = Inventory[ ID ] - Num
	end
	
	if ( Inventory[ ID ] <= 0 ) then
		Inventory[ ID ] = nil
	end
end )

usermessage.Hook( "SendBusinessCheck", function( um )
	LocalPlayer().Business = um:ReadShort()
end )

usermessage.Hook( "SendBlackMarketCheck", function( um )
	LocalPlayer().BlackMarket = um:ReadShort()
end )

usermessage.Hook( "SendTied", function( um )
	LocalPlayer().Tied = um:ReadBool()
end )

usermessage.Hook( "MapViewEnabled", function( um )
	MapView = um:ReadBool()
end )

usermessage.Hook( "IntroEnabled", function( um )
	Intro = um:ReadBool()
end )

usermessage.Hook( "CleanInventory", function()
	table.Empty( Inventory )
end )

-- Chat.
usermessage.Hook( "SendChatText", function( um )
	local amt = um:ReadShort()
	local build = { }
	local colour = true
	for i = 1, amt do
		if ( colour ) then
			local vec = um:ReadVector()
			local col = Color( vec.x, vec.y, vec.z, 255 )
			table.insert( build, col )
		else
			local str = um:ReadString()
			table.insert( build, str )
		end
		colour = !colour
	end
	chat.AddText( unpack( build ) )
end )

-- Character Loading.
Characters = { }

usermessage.Hook( "SendCharacters", function( um )
	local ID = um:ReadShort()
	Characters[ ID ] = { }
	Characters[ ID ][ "rpname" ] = um:ReadString()
	Characters[ ID ][ "model" ] = um:ReadString()
end )

usermessage.Hook( "CleanCharacterTable", function()
	table.Empty( Characters )
end )