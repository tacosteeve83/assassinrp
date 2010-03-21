local ITEM = { }

ITEM.Name = "First Aid Kit"
ITEM.UniqueID = "firstaidkit"
ITEM.Description = "Hold near patient then press actuator"
ITEM.Model = "models/Items/healthkit.mdl"
ITEM.Price = 25
ITEM.Business = false
ITEM.CWU = true
ITEM.UseAble = true
ITEM.Weight = 4

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:SetHealth( ply:Health() + 100 )
	end
end

RegisterItem( ITEM )