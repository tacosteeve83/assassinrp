local ITEM = { }

ITEM.Name = "SMG Ammo"
ITEM.UniqueID = "ammo_smg"
ITEM.Description = "100 Round Box."
ITEM.Model = "models/Items/BoxSRounds.mdl"
ITEM.Price = 150
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:GiveAmmo( 100,"smg1" )
	end
end

RegisterItem( ITEM )