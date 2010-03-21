local ITEM = { }

ITEM.Name = "Combine Breach Charge"
ITEM.UniqueID = "charge"
ITEM.Description = "Places a Breach charge."
ITEM.Model = "models/props_junk/cardboard_box004a.mdl"
ITEM.Price = 800
ITEM.Business = false
ITEM.BlackMarket = false
ITEM.UU = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "charge" )
	end
end

RegisterItem( ITEM )