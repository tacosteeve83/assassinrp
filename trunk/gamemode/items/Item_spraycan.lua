local ITEM = { }

ITEM.Name = "Spay Paint"
ITEM.UniqueID = "paint"
ITEM.Description = "A can of spray paint"
ITEM.Model = "models/props_junk/PopCan01a.mdl"
ITEM.Price = 40
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	end
end

RegisterItem( ITEM )