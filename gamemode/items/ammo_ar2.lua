local ITEM = { }

ITEM.Name = "AR2 Ammo"
ITEM.UniqueID = "ammo_ar2"
ITEM.Description = "Box full of 100 rounds."
ITEM.Model = "models/Items/BoxMRounds.mdl"
ITEM.Price = 200
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:GiveAmmo( 100,"ar2" )
	end
end

RegisterItem( ITEM )