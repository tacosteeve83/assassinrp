local ITEM = { }

ITEM.Name = "Vodka"
ITEM.UniqueID = "vodka"
ITEM.Description = "A strong clear liquid."
ITEM.Model = "models/props_junk/GlassBottle01a.mdl"
ITEM.Price = 35
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
				ply:SetHealth( ply:Health() - 10 )
	end
end

RegisterItem( ITEM )