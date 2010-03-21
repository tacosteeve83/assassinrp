local ITEM = { }

ITEM.Name = "Cyanide"
ITEM.UniqueID = "cyanide"
ITEM.Description = "A bottle of cyanide"
ITEM.Model = "models/props_junk/GlassBottle01a.mdl"
ITEM.Price = 200
ITEM.Business = true
ITEM.BlackMarket = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Kill()
	end
end

RegisterItem( ITEM )