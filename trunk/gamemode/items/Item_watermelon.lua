local ITEM = { }

ITEM.Name = "Watermelon"
ITEM.UniqueID = "watermelon"
ITEM.Description = "A tasty watermelon full of water!"
ITEM.Model = "models/props_junk/watermelon01.mdl"
ITEM.Price = 70
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = true
ITEM.Weight = 2

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		if ( ply:Health() > 0 and ply:Health() < 100 ) then
			ply:SetHealth( math.Clamp( ply:Health() + 30, 0, 100 ) )
		end
	end
end

RegisterItem( ITEM )