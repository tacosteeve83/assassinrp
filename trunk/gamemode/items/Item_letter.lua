local ITEM = { }

ITEM.Name = "Letter"
ITEM.UniqueID = "letter"
ITEM.Description = "Get a pen and you can write."
ITEM.Model = "models/props_c17/paper01.mdl"
ITEM.Price = 50
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = false
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	end
end

RegisterItem( ITEM )