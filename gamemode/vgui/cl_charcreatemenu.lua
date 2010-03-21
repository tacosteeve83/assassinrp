function CharacterCreateMenu()
	CharacterCreation = vgui.Create( "DFrame" )
	CharacterCreation:SetTitle( "Create a Character" )
	CharacterCreation:SetSize( 500, 500 )
	CharacterCreation:Center( )
	CharacterCreation:SetDraggable( true )
	CharacterCreation:ShowCloseButton( true )
	CharacterCreation:MakePopup( )
	
	local mdlSelection = vgui.Create( "DModelPanel", CharacterCreation )
	mdlSelection:SetSize( 300, 300 )
	mdlSelection:SetPos( 10, 20 )
	mdlSelection:SetModel( PlayerModels[ 1 ] )
	mdlSelection:SetAnimSpeed( 0.0 )
	mdlSelection:SetAnimated( true )
	mdlSelection:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlSelection:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlSelection:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlSelection:SetCamPos( Vector( 50, 0, 50 ) )
	mdlSelection:SetLookAt( Vector( 0, 0, 50 ) )
	mdlSelection:SetFOV( 70 )

	local RotateSlider = vgui.Create( "DNumSlider", CharacterCreation )
	RotateSlider:SetMax( 360 )
	RotateSlider:SetMin( 0 )
	RotateSlider:SetText( "Rotate" )
	RotateSlider:SetDecimals( 0 )
	RotateSlider:SetWidth( 300 )
	RotateSlider:SetPos( 10, 290 )

	local BodyButton = vgui.Create( "DButton", CharacterCreation )
	BodyButton:SetText( "Body" )
	BodyButton.DoClick = function()
		mdlSelection:SetCamPos( Vector( 50, 0, 50 ) )
		mdlSelection:SetLookAt( Vector( 0, 0, 50 ) )
		mdlSelection:SetFOV( 70 )
	end
	BodyButton:SetPos( 10, 50 )

	local FaceButton = vgui.Create( "DButton", CharacterCreation )
	FaceButton:SetText( "Face" )
	FaceButton.DoClick = function()
		mdlSelection:SetCamPos( Vector( 50, 0, 60 ) )
		mdlSelection:SetLookAt( Vector( 0, 0, 60 ) )
		mdlSelection:SetFOV( 40 )
	end
	FaceButton:SetPos( 10, 70 )

	function mdlSelection:LayoutEntity( Entity )
		self:RunAnimation()
		Entity:SetAngles( Angle( 0, RotateSlider:GetValue(), 0 ) )
	end

	local i = 1
	local LastMdl = vgui.Create( "DSysButton", CharacterCreation )
	LastMdl:SetType("left")
	LastMdl.DoClick = function()
		i = i - 1
		if ( i == 0 ) then
			i = #PlayerModels
		end
		mdlSelection:SetModel( PlayerModels[ i ] )
	end
	LastMdl:SetPos( 10, 165 )

	local NextMdl = vgui.Create( "DSysButton", CharacterCreation )
	NextMdl:SetType( "right" )
	NextMdl.DoClick = function()
		i = i + 1
		if ( i > #PlayerModels ) then
			i = 1
		end
		mdlSelection:SetModel( PlayerModels[ i ] )
	end
	NextMdl:SetPos( 245, 165 )
	
	local FirstNameLabel = vgui.Create( "DLabel", CharacterCreation )
	FirstNameLabel:SetSize( 60,25 )
	FirstNameLabel:SetPos( 10, 340 )
	FirstNameLabel:SetText( "First Name: " )

	local FirstNameTextEntry = vgui.Create( "DTextEntry", CharacterCreation )
	FirstNameTextEntry:SetSize( 100,25 )
	FirstNameTextEntry:SetPos( 10, 360 )
	FirstNameTextEntry:SetText( "" )

	local LastNameLabel = vgui.Create("DLabel", CharacterCreation)
	LastNameLabel:SetSize( 60,25 )
	LastNameLabel:SetPos( 10, 390 )
	LastNameLabel:SetText( "Last Name: " )

	local LastNameTextEntry = vgui.Create( "DTextEntry", CharacterCreation )
	LastNameTextEntry:SetSize( 100, 25 )
	LastNameTextEntry:SetPos( 10, 410 )
	LastNameTextEntry:SetText( "" )
	
	local ApplyButton = vgui.Create( "DButton", CharacterCreation )
	ApplyButton:SetText( "Apply" )
	ApplyButton:SetPos( 15, 460 )
	ApplyButton.DoClick = function()
		if( FirstNameTextEntry:GetValue() == "" or LastNameTextEntry:GetValue() == "" ) then
			LocalPlayer():PrintChat( "You must create a First and Last name!", false ) 	
			return
		else
			LocalPlayer():ConCommand( "eng_setrpnick " .. FirstNameTextEntry:GetValue() .. " " .. LastNameTextEntry:GetValue() )
			LocalPlayer( ):ConCommand( "rp_finishcharcreate " .. mdlSelection.Entity:GetModel() )
			CharacterCreation:Remove( )
		end
	end
end
concommand.Add( "charcreatemenu", CharacterCreateMenu )
