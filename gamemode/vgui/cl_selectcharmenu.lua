function SelectCharacterMenu()
	SelectCharacterFrame = vgui.Create( "DFrame" )
	SelectCharacterFrame:SetTitle( "Select Character" )
	SelectCharacterFrame:SetSize( 450, 360 )
	SelectCharacterFrame:Center( )
	SelectCharacterFrame:SetDraggable( false )
	SelectCharacterFrame:ShowCloseButton( true )
	SelectCharacterFrame:MakePopup( )
	SelectCharacterFrame.Paint = function()
		surface.SetDrawColor( 0, 0, 0, 0 )
		surface.DrawRect( 0, 0, SelectCharacterFrame:GetWide(), SelectCharacterFrame:GetTall() )
	end
	
	local List = vgui.Create( "DPanelList", SelectCharacterFrame )
	List:SetSize( 440, 320 )
	List:SetPos( 5, 25 )
	List:SetPadding( 3 )
	List:SetSpacing( 3 )
	
	local SelectCharacterForm = vgui.Create( "DForm" )
	SelectCharacterForm:SetSize( SelectCharacterFrame:GetWide() - 10, SelectCharacterFrame:GetTall() - 100 )
	SelectCharacterForm:SetPadding( 4 )
	SelectCharacterForm:SetName( "Characters" )
	List:AddItem( SelectCharacterForm )
	
	local CharacterList = vgui.Create( "DPanelList" )
	CharacterList:SetSize( SelectCharacterForm:GetWide(), SelectCharacterForm:GetTall() )
	CharacterList:SetPadding( 3 )
	CharacterList:SetSpacing( 5 )
	CharacterList:EnableVerticalScrollbar()
	SelectCharacterForm:AddItem( CharacterList )
	
	for ID = 1, table.getn( Characters ) do
		CharacterDPanel = vgui.Create( "DPanel" )
		CharacterDPanel:SetSize( 0, 75 )
		
		local SpawnIcon = vgui.Create( "SpawnIcon", CharacterDPanel )
		SpawnIcon:SetPos( 5, 5 )
		SpawnIcon:SetSize( 64, 64 )
		SpawnIcon:SetModel( Characters[ ID ][ "model" ] )
		SpawnIcon:SetToolTip( Characters[ ID ][ "credits" ] )
		SpawnIcon:SetVisible( SelectCharacterFrame:IsVisible() )
		SpawnIcon:SetMouseInputEnabled( false )
		
		local CharacterNameLabel = vgui.Create( "DLabel", CharacterDPanel )
		CharacterNameLabel:SetPos( 80, 10 )
		CharacterNameLabel:SetText( Characters[ ID ][ "rpname" ] )
		CharacterNameLabel:SetFont( "DefaultBold" )
		CharacterNameLabel:SetTextColor( Color( 255, 255, 255, 255 ) )
		CharacterNameLabel:SizeToContents()
		
		local SelectButton = vgui.Create( "DButton", CharacterDPanel )
		SelectButton:SetPos( 80, 40 )
		SelectButton:SetSize( 60, 20 )
		SelectButton:SetText( "Choose" )
		SelectButton.DoClick = function()
			LocalPlayer():ConCommand( "rp_selectcharacter " .. ID )
			SelectCharacterFrame:Remove()
		end
		
		local RemoveButton = vgui.Create( "DButton", CharacterDPanel )
		RemoveButton:SetPos( 180, 40 )
		RemoveButton:SetSize( 60, 20 )
		RemoveButton:SetText( "Delete" )
		RemoveButton.DoClick = function()
			local ContextMenu = DermaMenu()
			ContextMenu:AddOption( "Yes", function() LocalPlayer():ConCommand( "rp_removechar " .. ID ) SelectCharacterFrame:SetVisible( false ) LocalPlayer():ConCommand( "rp_startselectchar" ) end )
			ContextMenu:AddOption( "No", function() return end )
			ContextMenu:Open()
		end

		CharacterList:AddItem( CharacterDPanel )
	end

	local NewCharacterButton = vgui.Create( "DButton", SelectCharacterFrame )
	NewCharacterButton:SetText( "Create New Character" )
	NewCharacterButton.DoClick = function()
		LocalPlayer():ConCommand( "charcreatemenu" )
		SelectCharacterFrame:Remove()
	end
	List:AddItem( NewCharacterButton )
end
concommand.Add( "charselectframe", SelectCharacterMenu )
