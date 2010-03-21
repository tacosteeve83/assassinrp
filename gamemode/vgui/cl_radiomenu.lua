function RadioMenu()
	RadioMenuFrame = vgui.Create( "DFrame" )
	RadioMenuFrame:SetSize( 200, 200 )
	RadioMenuFrame:Center()
	RadioMenuFrame:SetTitle( "RadioMenu" )
	RadioMenuFrame:SetDraggable( true )
	RadioMenuFrame:ShowCloseButton( true )
	RadioMenuFrame:MakePopup()
	
	local CurrentFreq = vgui.Create( "DLabel", RadioMenuFrame )
	CurrentFreq:SetPos( 20, 30 )
	CurrentFreq:SetText( "Current Frequency: " .. LocalPlayer():GetNWInt( "Frequency" ) )
	CurrentFreq:SetFont( "ChatFont" )
	CurrentFreq:SizeToContents()
	CurrentFreq.Think = function()
		CurrentFreq:SetText( "Current Frequency: " .. LocalPlayer():GetNWInt( "Frequency" ) )
	end
	
	local NumSlider = vgui.Create( "DNumSlider", RadioMenuFrame )
	NumSlider:SetPos( 10, 70 )
	NumSlider:SetSize( 150, 100 )
	NumSlider:SetText( "Radio Frequency" )
	NumSlider:SetMin( 0 )
	NumSlider:SetMax( 30 )
	NumSlider:SetDecimals( 0 )
	
	local ConfirmButton = vgui.Create( "DButton", RadioMenuFrame )
	ConfirmButton:SetPos( 50, 150 )
	ConfirmButton:SetSize( 50, 20 )
	ConfirmButton:SetText( "Accept" )
	ConfirmButton.DoClick = function()
		LocalPlayer():ConCommand( "rp_changefrequency " .. NumSlider:GetValue() )
	end
end
concommand.Add( "RadioMenu", RadioMenu )

function UUMenu()

	DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( ScrW() / 2 - 320, ScrH() / 2 - 240 )
	DermaPanel:SetSize( 560, 480 )
	DermaPanel:SetTitle("")
	DermaPanel:ShowCloseButton( true )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()
	
	PropertySheet = vgui.Create( "DPropertySheet" )
	PropertySheet:SetParent( DermaPanel )
	PropertySheet:SetPos( 2, 30 )
	PropertySheet:SetSize( DermaPanel:GetWide() - 5, DermaPanel:GetTall() - 33 )

	local UU = vgui.Create( "DPanelList" )
	UU:EnableVerticalScrollbar()
	UU:SetSize( 0, PropertySheet:GetTall() )
	UU:SetSpacing( 3 )
	UU:SetPadding( 3 )

	for k, v in pairs( Items ) do
		if ( LocalPlayer().Business == 1 and v.UU ) then
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
			CostLabel:SetPos( 200, 48 )
			CostLabel:SetText( "Price: " .. v.Price )
			CostLabel:SetFont( "ChatFont" )
			CostLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			CostLabel:SizeToContents()
			
			local BuyButton = vgui.Create( "DButton", ShopDPanel )
			BuyButton:SetPos( 78, 48 )
			BuyButton:SetText( "Buy Item" )
			BuyButton.DoClick = function()
				RunConsoleCommand( "eng_buyitem2", v.UniqueID )
				gui.EnableScreenClicker( false )
			end
			UU:AddItem( ShopDPanel )
		end
	end

PropertySheet:AddSheet( "Storage", UU, "gui/silkicons/box", false, false, "Combine storage." )
end
usermessage.Hook("uu", UUMenu)

function CWUMenu()

	DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( ScrW() / 2 - 320, ScrH() / 2 - 240 )
	DermaPanel:SetSize( 560, 480 )
	DermaPanel:SetTitle("")
	DermaPanel:ShowCloseButton( true )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()
	
	PropertySheet = vgui.Create( "DPropertySheet" )
	PropertySheet:SetParent( DermaPanel )
	PropertySheet:SetPos( 2, 30 )
	PropertySheet:SetSize( DermaPanel:GetWide() - 5, DermaPanel:GetTall() - 33 )

	local Warehouse = vgui.Create( "DPanelList" )
	Warehouse:EnableVerticalScrollbar()
	Warehouse:SetSize( 0, PropertySheet:GetTall() )
	Warehouse:SetSpacing( 3 )
	Warehouse:SetPadding( 3 )
	
	for k, v in pairs( Items ) do
		if ( LocalPlayer().Business == 1 and v.CWU ) then
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
			CostLabel:SetPos( 200, 48 )
			CostLabel:SetText( "Price: " .. v.Price )
			CostLabel:SetFont( "ChatFont" )
			CostLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
			CostLabel:SizeToContents()
			
			local BuyButton = vgui.Create( "DButton", ShopDPanel )
			BuyButton:SetPos( 78, 48 )
			BuyButton:SetText( "Buy Item" )
			BuyButton.DoClick = function()
				RunConsoleCommand( "eng_buyitem2", v.UniqueID )
				gui.EnableScreenClicker( false )
			end
			Warehouse:AddItem( ShopDPanel )
		end
	end

PropertySheet:AddSheet( "Warehouse", Warehouse, "gui/silkicons/box", false, false, "Highly priced rare items." )
end
usermessage.Hook("cwu", CWUMenu)
