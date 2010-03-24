local ITEM = { }

ITEM.Name = "Milk"
ITEM.UniqueID = "milk"
ITEM.Description = "A carton of milk"
ITEM.Model = "models/francis115/milk.mdl"
ITEM.Price = 25
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:SetHealth( ply:Health() + 25 )
	end
end

RegisterItem( ITEM )