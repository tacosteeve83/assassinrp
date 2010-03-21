local ITEM = { }

ITEM.Name = "Zip Ties"
ITEM.UniqueID = "zip"
ITEM.Description = "Tie a person up."
ITEM.Model = "models/props_junk/cardboard_box004a.mdl"
ITEM.Price = 200
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "rp_zipties" )
	end
end

RegisterItem( ITEM )