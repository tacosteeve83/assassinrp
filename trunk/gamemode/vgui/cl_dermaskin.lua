local SKIN = { }

SKIN.fontCategoryHeader	= "TabLarge"
SKIN.fontButton	= "TabLarge"
SKIN.fontFrame = "TabLarge"
SKIN.fontTab = "TabLarge"

SKIN.colOutline	= Color( 0, 0, 0, 150 )

function SKIN:DrawGenericBackground( x, y, w, h, color )
	surface.SetDrawColor( color )
--	surface.SetDrawColor( 50, 0, 0, 150 )
--	surface.SetDrawColor( 50, 0, 0, 150 )
	draw.RoundedBox( 4, x, y, w, h, color )
end

function SKIN:DrawSquaredBox( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawRect( x, y, w, h )
	
	surface.SetDrawColor( self.colOutline )
	surface.DrawOutlinedRect( x, y, w, h )
end

function SKIN:PaintFrame( panel )
	local color = self.bg_color

	self:DrawSquaredBox( 0, 0, panel:GetWide(), panel:GetTall(), color )
	
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawRect( 0, 0, panel:GetWide(), 21 )
	
	surface.SetDrawColor( self.colOutline )
	surface.DrawRect( 0, 21, panel:GetWide(), 1 )
end
derma.DefineSkin( "KIWISKINSkin", "", SKIN )