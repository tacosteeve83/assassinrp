local ITEM = { }

ITEM.Name = "Spay Paint"
ITEM.UniqueID = "paint"
ITEM.Description = "A can of spray paint"
ITEM.Model = "models/props_junk/PopCan01a.mdl"
ITEM.Price = 50
ITEM.Business = true
ITEM.BlackMarket = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	end
end

RegisterItem( ITEM )