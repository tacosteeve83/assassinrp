local ITEM = { }

ITEM.Name = "Breen's Water"
ITEM.UniqueID = "water"
ITEM.Description = "A bottle of breen's water"
ITEM.Model = "models/props_junk/garbage_glassbottle002a.mdl"
ITEM.Price = 15
ITEM.Business = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		if ( ply:Health() > 0 and ply:Health() < 100 ) then
			ply:SetHealth( math.Clamp( ply:Health() + 10, 0, 100 ) )
		end
	end
end

RegisterItem( ITEM )