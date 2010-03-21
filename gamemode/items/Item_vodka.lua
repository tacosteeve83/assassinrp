local ITEM = { }

ITEM.Name = "Vodka"
ITEM.UniqueID = "vodka"
ITEM.Description = "A strong clear liquid."
ITEM.Model = "models/props_junk/GlassBottle01a.mdl"
ITEM.Price = 35
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:SetHealth( ply:Health() - 10 )
	end
end

RegisterItem( ITEM )