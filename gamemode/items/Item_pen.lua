local ITEM = { }

ITEM.Name = "Pen"
ITEM.UniqueID = "pen"
ITEM.Description = "You use it on paper to write on it."
ITEM.Model = "models/props_c17/TrapPropeller_Lever.mdl"
ITEM.Price = 30
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = false
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	end
end

RegisterItem( ITEM )