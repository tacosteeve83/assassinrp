Inventory = { }

function GM:ScoreboardShow()
	PlayerMenu()
	PlayerMenuFrame:SetVisible( true )
	
	gui.EnableScreenClicker( true )
end

function GM:ScoreboardHide()
	PlayerMenuFrame:SetVisible( false )
	PlayerMenuFrame:Remove()
	
	gui.EnableScreenClicker( false )
end

function PlayerMenu()
	PlayerMenuFrame = vgui.Create( "DFrame" )
	PlayerMenuFrame:SetSize( 560, 480 )
	PlayerMenuFrame:Center()
	PlayerMenuFrame:SetTitle( "Scoreboard" )
	PlayerMenuFrame:SetDraggable( true )
	PlayerMenuFrame:ShowCloseButton( false )
	PlayerMenuFrame:MakePopup()
	
	PropertySheet = vgui.Create( "DPropertySheet" )
	PropertySheet:SetParent( PlayerMenuFrame )
	PropertySheet:SetPos( 2, 30 )
	PropertySheet:SetSize( PlayerMenuFrame:GetWide() - 5, PlayerMenuFrame:GetTall() - 33 )
	
	local ScoreBoardList = vgui.Create( "DPanelList" )
	ScoreBoardList:EnableVerticalScrollbar()
	ScoreBoardList:SetSize( 0, PropertySheet:GetTall() )
	ScoreBoardList:SetSpacing( 3 )
	ScoreBoardList:SetPadding( 3 )
	
	local ScoreBoardInfoDPanel = vgui.Create( "DPanel" )
	ScoreBoardInfoDPanel:SetSize( 0, 20 )

	local TotalPlayersLabel = vgui.Create( "DLabel", ScoreBoardInfoDPanel )
	TotalPlayersLabel:SetPos( 445, 2.5 )
	TotalPlayersLabel:SetText( "Players: " .. #player.GetAll() )
	TotalPlayersLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
	TotalPlayersLabel:SizeToContents()
	ScoreBoardList:AddItem( ScoreBoardInfoDPanel )
	
	for _, j in pairs( Teams ) do
		if ( team.NumPlayers( j.ID ) != 0 ) then
			j.CollapsibleCategory = vgui.Create( "DCollapsibleCategory" )
			j.CollapsibleCategory:SetExpanded( 1 )
			j.CollapsibleCategory:SetLabel( j.Name )
			ScoreBoardList:AddItem( j.CollapsibleCategory )
		end
		
		local SomeList = vgui.Create( "DPanelList" )
		SomeList:SetAutoSize( true )
		SomeList:SetSpacing( 5 )
		SomeList:SetPadding( 3 )
		SomeList:EnableVerticalScrollbar( true )
		
		for k, v in pairs( player.GetAll() ) do
			v.DPanel = vgui.Create( "DPanel" )
			v.DPanel:SetSize( 0, 38 )
			
			v.SpawnIcon = vgui.Create( "SpawnIcon", v.DPanel )
			v.SpawnIcon:SetPos( 2, 2 )
			v.SpawnIcon:SetIconSize( 35 )
			v.SpawnIcon:SetModel( v:GetModel() )
			v.SpawnIcon:SetToolTip( "Ping: " .. v:Ping() .. "\n" .. v:GetNWString( "credits" ) .. " Coppers" )
			v.SpawnIcon:SetVisible( PlayerMenuFrame:IsVisible() )
			
			v.NameLabel = vgui.Create( "DLabel", v.DPanel )
			v.NameLabel:SetPos( 50, 4 )
			v.NameLabel:SetText( v:Nick() )
			v.NameLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			v.NameLabel:SizeToContents()
			
			
			if ( v:Team() == j.ID ) then
				SomeList:AddItem( v.DPanel )
			end
		end
		
		if ( team.NumPlayers( j.ID ) != 0 ) then
			j.CollapsibleCategory:SetContents( SomeList )
		end
	end
	
	
	PropertySheet:AddSheet( " ", ScoreBoardList, "gui/silkicons/group", false, false, "ScoreBoard" )
end

function Menu()

DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( ScrW() / 2 - 320, ScrH() / 2 - 240 )
DermaPanel:SetSize( 560, 480 )
DermaPanel:SetTitle("User Menu")
DermaPanel:ShowCloseButton( true )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:MakePopup()
	
PropertySheet = vgui.Create( "DPropertySheet" )
PropertySheet:SetParent( DermaPanel )
PropertySheet:SetPos( 2, 30 )
PropertySheet:SetSize( DermaPanel:GetWide() - 5, DermaPanel:GetTall() - 33 )

	local PlayerInfo = vgui.Create( "DPanelList" )
	PlayerInfo:SetPadding(20);
	PlayerInfo:SetSpacing(20);
	PlayerInfo:EnableHorizontal(false);
	
	local icdata = vgui.Create( "DForm" );
	icdata:SetPadding(4);
	icdata:SetName(LocalPlayer():Nick() or "");
	
	local FullData = vgui.Create("DPanelList");
	FullData:SetSize(0, 84);
	FullData:SetPadding(10);
	
	local DataList = vgui.Create("DPanelList");
	DataList:SetSize(0, 64);
	
	local spawnicon = vgui.Create( "SpawnIcon");
	spawnicon:SetModel(LocalPlayer():GetModel());
	spawnicon:SetSize( 64, 64 );
	DataList:AddItem(spawnicon);
	
	local DataList2 = vgui.Create( "DPanelList" )
	
	local label3 = vgui.Create("DLabel");
	label3:SetText("Role: " .. team.GetName(LocalPlayer():Team()));
	DataList2:AddItem(label3);

	local label4 = vgui.Create("DLabel");
	label4:SetText("Coppers: " .. LocalPlayer():GetNWString("Credits"));
	DataList2:AddItem(label4);

	local Divider = vgui.Create("DHorizontalDivider");
	Divider:SetLeft(spawnicon);
	Divider:SetRight(DataList2);
	Divider:SetLeftWidth(64);
	Divider:SetHeight(80);
	
	DataList:AddItem(spawnicon);
	DataList:AddItem(DataList2);
	DataList:AddItem(Divider);

	FullData:AddItem(DataList)
	
	icdata:AddItem(FullData)
	
	PlayerInfo:AddItem(icdata)
		
	local InventoryList = vgui.Create( "DPanelList" )
	InventoryList:EnableVerticalScrollbar()
	InventoryList:SetSize( 0, PropertySheet:GetTall() )
	InventoryList:SetSpacing( 3 )
	InventoryList:SetPadding( 3 )

	for k, v in pairs( Inventory ) do

		InventoryDPanel = vgui.Create( "DPanel" )
		InventoryDPanel:SetSize( 0, 75 )
		
		local SpawnIcon = vgui.Create( "SpawnIcon", InventoryDPanel )
		SpawnIcon:SetPos( 5, 5 )
		SpawnIcon:SetSize( 64, 64 )
		SpawnIcon:SetModel( Items[ k ].Model )
		SpawnIcon:SetVisible( DermaPanel:IsVisible() )
		SpawnIcon:SetMouseInputEnabled( false )
		
		local NameLabel = vgui.Create( "DLabel", InventoryDPanel )
		NameLabel:SetPos( 78, 10 )
		NameLabel:SetText( Items[ k ].Name )
		NameLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
		NameLabel:SizeToContents()
				
		local AmountLabel = vgui.Create( "DLabel", InventoryDPanel )
		AmountLabel:SetPos( 300, 48  )
		AmountLabel:SetText( "Amount: " .. v )
		AmountLabel:SetFont( "ChatFont" )
		AmountLabel:SetTextColor( Color( 0, 0, 255, 255 ) )
		AmountLabel:SizeToContents()
		
		local DescLabel = vgui.Create( "DLabel", InventoryDPanel )
		DescLabel:SetPos( 78, 28 )
		DescLabel:SetText( Items[ k ].Description )
		DescLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
		DescLabel:SizeToContents()
		
		if ( Items[ k ].UseAble ) then
			local UseButton = vgui.Create( "DButton", InventoryDPanel )
			UseButton:SetPos( 78, 48 )
			UseButton:SetText( "Use Item" )
			UseButton.DoClick = function()
				RunConsoleCommand( "eng_useitem", Items[ k ].UniqueID )
				DermaPanel:SetVisible( false )
				gui.EnableScreenClicker( false )
			end
		else
		end
		
		local DropButton = vgui.Create( "DButton", InventoryDPanel )
		DropButton:SetPos( 154, 48 )
		DropButton:SetText( "Drop Item" )
		DropButton.DoClick = function()
			RunConsoleCommand( "eng_dropitem", Items[ k ].UniqueID )
			DermaPanel:SetVisible( false )
			gui.EnableScreenClicker( false )
		end
		InventoryList:AddItem( InventoryDPanel )
	end

	local BusinessList = vgui.Create( "DPanelList" )
	BusinessList:EnableVerticalScrollbar()
	BusinessList:SetSize( 0, PropertySheet:GetTall() )
	BusinessList:SetSpacing( 3 )
	BusinessList:SetPadding( 3 )
	
	for k, v in pairs( Items ) do
		if ( LocalPlayer().Business == 1 and v.Business ) then
			ShopDPanel = vgui.Create( "DPanel" )
			ShopDPanel:SetSize( 0, 75 )
			
			local SpawnIcon = vgui.Create( "SpawnIcon", ShopDPanel )
			SpawnIcon:SetPos( 5, 5 )
			SpawnIcon:SetSize( 64, 64 )
			SpawnIcon:SetModel( v.Model )
			SpawnIcon:SetVisible( DermaPanel:IsVisible() )
			SpawnIcon:SetMouseInputEnabled( false )
			
			local NameLabel = vgui.Create( "DLabel", ShopDPanel )
			NameLabel:SetPos( 78, 10 )
			NameLabel:SetText( v.Name )
			NameLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			NameLabel:SizeToContents()
			
			local DescLabel = vgui.Create( "DLabel", ShopDPanel )
			DescLabel:SetPos( 78, 28 )
			DescLabel:SetText( v.Description )
			DescLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			DescLabel:SizeToContents()
			
			local CostLabel = vgui.Create( "DLabel", ShopDPanel )
			CostLabel:SetPos( 158, 52 )
			CostLabel:SetText( "Price: " .. v.Price .. " Coppers")
			CostLabel:SetFont( "ChatFont" )
			CostLabel:SetTextColor( Color( 0, 200, 0, 255 ) )
			CostLabel:SizeToContents()

			local BuyButton = vgui.Create( "DButton", ShopDPanel )
			BuyButton:SetPos( 78, 48 )
			BuyButton:SetText( "Buy Item" )
			BuyButton.DoClick = function()
				RunConsoleCommand( "eng_buyitem", v.UniqueID )
				gui.EnableScreenClicker( false )
			end
			BusinessList:AddItem( ShopDPanel )
		end
	end
	
	local BlackMarketList = vgui.Create( "DPanelList" )
	BlackMarketList:EnableVerticalScrollbar()
	BlackMarketList:SetSize( 0, PropertySheet:GetTall() )
	BlackMarketList:SetSpacing( 3 )
	BlackMarketList:SetPadding( 3 )
	
	for k, v in pairs( Items ) do
		if ( LocalPlayer().BlackMarket == 1 and v.BlackMarket ) then
			ShopDPanel = vgui.Create( "DPanel" )
			ShopDPanel:SetSize( 0, 75 )
			
			local SpawnIcon = vgui.Create( "SpawnIcon", ShopDPanel )
			SpawnIcon:SetPos( 5, 5 )
			SpawnIcon:SetSize( 64, 64 )
			SpawnIcon:SetModel( v.Model )
			SpawnIcon:SetVisible( DermaPanel:IsVisible() )
			SpawnIcon:SetMouseInputEnabled( false )
			
			local NameLabel = vgui.Create( "DLabel", ShopDPanel )
			NameLabel:SetPos( 78, 10 )
			NameLabel:SetText( v.Name )
			NameLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			NameLabel:SizeToContents()
			
			local DescLabel = vgui.Create( "DLabel", ShopDPanel )
			DescLabel:SetPos( 78, 28 )
			DescLabel:SetText( v.Description )
			DescLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			DescLabel:SizeToContents()
			
			local CostLabel = vgui.Create( "DLabel", ShopDPanel )
			CostLabel:SetPos( 225, 48 )
			CostLabel:SetText( "Price: " .. v.Price .. "")
			CostLabel:SetFont( "ChatFont" )
			CostLabel:SetTextColor( Color( 0, 255, 0, 255 ) )
			CostLabel:SizeToContents()

			local BuyButton = vgui.Create( "DButton", ShopDPanel )
			BuyButton:SetPos( 78, 48 )
			BuyButton:SetText( "Buy Item" )
			BuyButton.DoClick = function()
				RunConsoleCommand( "eng_buyitem2", v.UniqueID )
				gui.EnableScreenClicker( false )
			end
			BlackMarketList:AddItem( ShopDPanel )
		end
	end
	
	if ( LocalPlayer():IsAdmin() ) then
		AdminPanel = vgui.Create( "DPanelList" )
		AdminPanel:SetParent( DermaPanel )
		AdminPanel:SetSize( 280, 240 )
		AdminPanel:SetSpacing( 5 )
		AdminPanel:SetPadding( 5 )
		AdminPanel:EnableVerticalScrollbar( true )
		
		for k, v in pairs( player.GetAll() ) do
			local CollapsableCategory = vgui.Create( "DCollapsibleCategory" )
			CollapsableCategory:SetExpanded( 1 )
			CollapsableCategory:SetLabel( v:Nick() )
			CollapsableCategory:SetSize( 500, 0 )
			AdminPanel:AddItem( CollapsableCategory )
			
			local DataList = vgui.Create( "DPanelList" )
			DataList:SetAutoSize( true )
			DataList:SetSpacing( 5 )
			DataList:EnableVerticalScrollbar( true )
			
			
			local BanButton = vgui.Create( "DButton" )
			BanButton:SetText( "Perm-Ban" )
			BanButton.DoClick = function()
				LocalPlayer():ConCommand( "rp_ban \"" .. v:Nick() .. "\"" )
			end
			DataList:AddItem( BanButton )
			
			local TempBanButton = vgui.Create( "DButton" )
			TempBanButton:SetText( "1 Hour Ban" )
			TempBanButton.DoClick = function()
				LocalPlayer():ConCommand( "rp_ban \"" .. v:Nick() .. "\" 60" )
			end
			DataList:AddItem( TempBanButton )

			local TempBan2Button = vgui.Create( "DButton" )
			TempBan2Button:SetText( "1 Day Ban" )
			TempBan2Button.DoClick = function()
				LocalPlayer():ConCommand( "rp_ban \"" .. v:Nick() .. "\" 1440" )
			end

			DataList:AddItem( TempBan2Button )
			local KickButton = vgui.Create( "DButton" )
			KickButton:SetText( "Kick" )
			KickButton.DoClick = function()
				LocalPlayer():ConCommand( "rp_kick \"" .. v:Nick() .. "\"" )
			end
			DataList:AddItem( KickButton )
			
			local TTButton = vgui.Create( "DButton" )
			TTButton:SetText( "Tool trust" )
			TTButton.DoClick = function()
				local ContextMenu = DermaMenu()
				ContextMenu:AddOption( "Give", function() LocalPlayer():ConCommand( "rp_tooltrust \"" .. v:Nick() .. "\" 1" ) end )
				ContextMenu:AddOption( "Remove", function() LocalPlayer():ConCommand( "rp_tooltrust \"" .. v:Nick() .. "\" 0" ) end )
				ContextMenu:Open()
			end
			DataList:AddItem( TTButton )
			
			local PhysTrustButton = vgui.Create( "DButton" )
			PhysTrustButton:SetText( "Physgun Trust" )
			PhysTrustButton.DoClick = function()
				local ContextMenu = DermaMenu()
				ContextMenu:AddOption( "Give", function() LocalPlayer():ConCommand( "rp_phystrust \"" .. v:Nick() .. "\" 1" ) end )
				ContextMenu:AddOption( "Remove", function() LocalPlayer():ConCommand( "rp_phystrust \"" .. v:Nick() .. "\" 0" ) end )
				ContextMenu:Open()
			end	
			DataList:AddItem( PhysTrustButton )

			local BusinessTrustButton = vgui.Create( "DButton" )
			BusinessTrustButton:SetText( "Shop Trust" )
			BusinessTrustButton.DoClick = function()
				local ContextMenu = DermaMenu()
				ContextMenu:AddOption( "Give", function() LocalPlayer():ConCommand( "rp_businesstrust \"" .. v:Nick() .. "\" 1" ) end )
				ContextMenu:AddOption( "Remove", function() LocalPlayer():ConCommand( "rp_businesstrust \"" .. v:Nick() .. "\" 0" ) end )
				ContextMenu:Open()
			end	
			DataList:AddItem( BusinessTrustButton )
			
			local BlackMarketTrustButton = vgui.Create( "DButton" )
			BlackMarketTrustButton:SetText( "Black Market Trust" )
			BlackMarketTrustButton.DoClick = function()
				local ContextMenu = DermaMenu()
				ContextMenu:AddOption( "Give", function() LocalPlayer():ConCommand( "rp_bmtrust \"" .. v:Nick() .. "\" 1" ) end )
				ContextMenu:AddOption( "Remove", function() LocalPlayer():ConCommand( "rp_bmtrust \"" .. v:Nick() .. "\" 0" ) end )
				ContextMenu:Open()
			end	
			DataList:AddItem( BlackMarketTrustButton )
			
			CollapsableCategory:SetContents( DataList )
		end	
	end
	
	local FlagsList = vgui.Create( "DPanelList" )
	FlagsList:EnableVerticalScrollbar()
	FlagsList:SetSize( 0, PropertySheet:GetTall() )
	
	local FlagsListView = vgui.Create( "DListView" )
	FlagsListView:SetSize( 0, 400 )
	FlagsListView:SetMultiSelect( false )
	FlagsListView:AddColumn( "Name" )
	FlagsListView:AddColumn( "Key" )
	function FlagsListView:DoDoubleClick( LineID, Line )
		RunConsoleCommand( "rp_flag", Teams[ LineID ].Flag )
		gui.EnableScreenClicker( false )
		DermaPanel:SetVisible( false )
	end
	
	for k, v in pairs( Teams ) do
		FlagsListView:AddLine( v.Name, v.Flag )
	end
	FlagsList:AddItem( FlagsListView )
	
	local HelpDPanelList = vgui.Create( "DPanelList" )
	HelpDPanelList:EnableVerticalScrollbar()
	HelpDPanelList:SetSize( 0, PropertySheet:GetTall() )
	HelpDPanelList:SetPadding( 5 )
	
	local function AddHelpText( text )
		local HelpLabel = vgui.Create( "DLabel" )
		HelpLabel:SetText( text )
		HelpLabel:SetFont( "ChatFont" )
		HelpLabel:SetTextColor( Color( 255, 255, 0, 255 ) )
		HelpLabel:SizeToContents()
		HelpDPanelList:AddItem( HelpLabel )
	end
	
	local HelpLines = 
	{
		"[ F Menu's ]\n",
		"F1 - User menu",
		"F2 - Works for weapon merchant.",
		"F3 - Pops up character selection menu(Can't close unless you pick 1).",
		"F4 - Buy doors.\n\n",
		"[ Chat Commands ]\n",
		"/w - Whisper",
		"/me - Me",
		".// - LOOC",
		"/y - Yell",
		"/adv (/advert) - Advert",
		"/r (/radio) - Radio",
		"/dis (/dispatch) - Dispatch",
		"/br (/broadcast) - Broadcast",
		"/cr - Place a help request",
		"// (/a)(/ooc) - OOC\n",
		"/citizen - Citizen",
		"/cwu - Citizen Workers Union",
		"/vort - Vortagon",
		"/rct - Recruit",
		"/cca - Combine Civil Authority",
		"/sql - CCA Squad Leader",
		"/cmd - CCA Commander",
		"/ow - Overwatch",
		"/eow - Overwatch Elite",
		"/ca - City Admin.",
		"/re - Restitance Member",
		"/rel - Restitance Leader",
		"/save - Save your profile manually\n\n",
		"[ Console Commands ]\n",
		"rp_flag (c,wm) changes your role.",
		"rp_startselectchar - Select a character or create a new one.",
		"rp_freq - Changes the channel of the radio",
		"rp_dropweapon - Drops the players current weapon",
		"rp_cca1 - Turns cca into a female cca.",
		"rp_ca_model1 - Turns cca into a male CA",
		"rp_ca_model2 - Turns cca into a female CA",
		"rp_restartmap - Restarts the current map",
		"rp_setflag - Sets te flag of a player",
		"rp_rpnick - Sets the players name",
		"rp_givemoney - Give the player infront of you credits",
		"rp_newdoor - Adds a new door to the server to be bought.",
		"rp_doorname - Sets the door(s) name.",
		"rp_storewep - Place your weapon back in your inventory",
		"rp_tooltrust - Gives/Removes a players access",
		"rp_physguntrust - Gives/Removes a players access",
		"rp_businesstrust - Gives/Removes a players access",
		"rp_oocdelay - Set the delay  for each message for ooc chat"
	}
	
	for _, v in pairs( HelpLines ) do
		AddHelpText( v )
	end

	PropertySheet:AddSheet( "Player", PlayerInfo, "gui/silkicons/user", false, false, "Your Character details." )
	PropertySheet:AddSheet( "Inventory", InventoryList, "gui/silkicons/application_view_tile", false, false, "View your inventory." )
	PropertySheet:AddSheet( "Shop", BusinessList, "gui/silkicons/box", false, false, "Buy Items." )
	if ( LocalPlayer().BlackMarket == 1 ) then
	PropertySheet:AddSheet( "Black Market", BlackMarketList, "gui/silkicons/box", false, false, "Buy items." )
	end
	PropertySheet:AddSheet( "Jobs", FlagsList, "gui/silkicons/group", false, false, "View jobs and choose!" )
--	PropertySheet:AddSheet( "Help", HelpDPanelList, "gui/silkicons/star", false, false, "Commands and info." )
	if ( LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() ) then	PropertySheet:AddSheet( "Admin Panel", AdminPanel, "gui/silkicons/shield", false, false, "Manage Players." ) end
end
usermessage.Hook("playermenu", Menu)

function RationMenu()
	if ( LocalPlayer():IsCombine() ) then
		RationMenuFrame = vgui.Create( "DFrame" )
		RationMenuFrame:SetSize( 220, 100 )
		RationMenuFrame:SetPos( 10, 40 )
		RationMenuFrame:SetTitle( "Ration Distribution" )
		RationMenuFrame:SetDraggable( true )
		RationMenuFrame:ShowCloseButton( true )
		RationMenuFrame:MakePopup()
		
		local SpawnIcon = vgui.Create( "SpawnIcon", RationMenuFrame )
		SpawnIcon:SetPos( 5, 28 )
		SpawnIcon:SetSize( 64, 64 )
		SpawnIcon:SetModel( "models/weapons/w_package.mdl" )
		SpawnIcon:SetMouseInputEnabled( false )
		SpawnIcon:SetVisible( RationMenuFrame:IsVisible() )
		
		local RationAmountLabel = vgui.Create( "DLabel", RationMenuFrame )
		RationAmountLabel:SetPos( 75, 35 )
		RationAmountLabel:SetText( "Ration Count: " .. GetGlobalInt( "RationSupply" ) )
		RationAmountLabel:SetFont( "ChatFont" )
		RationAmountLabel:SizeToContents()
		RationAmountLabel.Think = function()
			RationAmountLabel:SetText( "Ration Count: " .. GetGlobalInt( "RationSupply" ) )
		end
		
		local RationSpawnButton = vgui.Create( "DButton", RationMenuFrame )
		RationSpawnButton:SetPos( 90, 70 )
		RationSpawnButton:SetSize( 70, 20 )
		RationSpawnButton:SetText( "Drop Ration" )
		RationSpawnButton:SetFont( "ChatFont" )
		RationSpawnButton.DoClick = function()
			LocalPlayer():ConCommand( "combinerationspawning" )
		end
	end
end
concommand.Add( "rationmenu", RationMenu)

function DoorTitleMenu()
	DoorTitle = vgui.Create( "DFrame" )
	DoorTitle:SetSize( 220, 100 )
	DoorTitle:SetPos( 10, 40 )
	DoorTitle:SetTitle( "Door Menu" )
	DoorTitle:SetDraggable( true )
	DoorTitle:ShowCloseButton( true )
	DoorTitle:MakePopup()

	local DoorTitleLabel = vgui.Create( "DLabel", DoorTitle )
	DoorTitleLabel:SetSize( 30, 25 )
	DoorTitleLabel:SetPos( 10, 20 )
	DoorTitleLabel:SetText( "Title: " )

	local DoorTitleTextEntry = vgui.Create( "DTextEntry", DoorTitle )
	DoorTitleTextEntry:SetSize( 100, 25 )
	DoorTitleTextEntry:SetPos( 10, 40 )
	DoorTitleTextEntry:SetText( "" )
	
	local ApplyButton = vgui.Create( "DButton", DoorTitle )
	ApplyButton:SetText( "Apply" )
	ApplyButton:SetPos( 15, 70 )
	ApplyButton.DoClick = function()

	LocalPlayer():ConCommand( "rp_doortitle " .. DoorTitleTextEntry:GetValue() )
	DoorTitle:Remove( )
	end
end
concommand.Add( "settitle", DoorTitleMenu)
