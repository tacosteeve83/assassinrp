
-- Set's the char name
function CharCreateSetRPNick( ply, cmd, args )
	ply:SetNWString( "RPNick", table.concat( args, " " ) )
end
concommand.Add( "eng_setrpnick", CharCreateSetRPNick )

-- Start chatting. Hacky fucking method for combine voder.
function ChatOn( ply )
	ply:SetNWBool( "ChatOpen", true )

	if ply:IsCombine2() and ply:HasItem( "radio" ) then
		local num = math.random( 1, 2 )
		ply:EmitSound( Sound( "npc/metropolice/vo/on" .. num .. ".wav", 35, 100 ) )
	end
end
concommand.Add( "eng_chatopen", ChatOn )

-- End chatting. Hacky fucking method for combine voder.
function ChatOff( ply )
	ply:SetNWBool( "ChatOpen", false )

	if ply:IsCombine2() and ply:HasItem( "radio" ) then
		local num = math.random( 1, 4 );
		ply:EmitSound( Sound( "npc/metropolice/vo/off" .. num .. ".wav", 35, 100 ) );
	end
end
concommand.Add( "eng_chatclose", ChatOff )

-- Open the ration menu?
function RationMenuOpen( ply )
	if ( LocalPlayer():IsCombine() ) then
		RunConsoleCommand( "rationmenu" )
			else
		ply:PrintChat( "You need to be a combine.", false)
	end
end
concommand.Add( "ration", RationMenuOpen )

-- Use a item inside your inventory.
function UseItem( ply, cmd, args )
	if ( ply.Tied or !ply:Alive() ) then
		return
	end
	
	for k, v in pairs( ply:GetCurrentCharInventory() ) do
		if ( k == args[ 1 ] ) then
		 
			if ( k == "radio" ) then
				Items[ args[ 1 ] ]:UseEnt( ply )
				return
			end
			
			Items[ args[ 1 ] ]:UseEnt( ply )
			if ( Items[ args[ 1 ] ].Book or Items[ args[ 1 ] ].Clothing or Items[ args[ 1 ] ].Fix ) then
				return 
			end
			ply:RemoveItem( args[ 1 ], 1 )
			return
		end
	end
end
concommand.Add( "eng_useitem", UseItem )

-- Drop a item inside your inventory.
function DropItem( ply, cmd, args )
	if ( ply.Tied or !ply:Alive() ) then return end
	
	for k, v in pairs( ply:GetCurrentCharInventory() ) do
		if ( k == args[ 1 ] ) then 
			ply:SpawnItem( args[ 1 ] )
			ply:RemoveItem( args[ 1 ], 1 )
			return
		end
	end
end
concommand.Add( "eng_dropitem", DropItem )

-- Buy a item.
function BuyItem( ply, cmd, args )
	if ( ply.Tied or !ply:Alive() ) then 
			ply:PrintChat( "You can't buy anything when you are dead/tied.", false )
	return end

	if ( Items[ args[ 1 ] ].Business and ply:GetNWInt( "Credits" ) >= Items[ args[ 1 ] ].Price ) then
		ply:TakeCredits( Items[ args[ 1 ] ].Price )
		ply:GiveItem( args[ 1 ], 1 )
		ply:PrintChat( "Item purchased and placed in your inventory.", false )
	else
		ply:PrintChat( "Not enough credits to buy this item.", false )
	end
end
concommand.Add( "eng_buyitem", BuyItem )-- Buy a item.

function BuyItem2( ply, cmd, args )
	if ( ply.Tied or !ply:Alive() ) then 
			ply:PrintChat( "You can't buy anything when you are dead/tied.", false )
	return end

	if ( ply:GetNWInt( "Credits" ) >= Items[ args[ 1 ] ].Price ) then
		ply:TakeCredits( Items[ args[ 1 ] ].Price )
		ply:GiveItem( args[ 1 ], 1 )
		ply:PrintChat( "Item purchased and placed in your inventory.", false )
		else
		ply:PrintChat( "Either your not weapon's merchant or you don't have enough credits.", false )
	end
end
concommand.Add( "eng_buyitem2", BuyItem2 )-- Buy a item.

