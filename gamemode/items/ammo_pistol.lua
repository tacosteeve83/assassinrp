local ITEM = { }

ITEM.Name = "Pistol"
ITEM.UniqueID = "ammo_pistol"
ITEM.Description = "Box of pistol ammo."
ITEM.Model = "models/Items/357ammobox.mdl"
ITEM.Price = 50
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true
ITEM.Weight = 5

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:GiveAmmo( 50,"Pistol" )
	end
end

RegisterItem( ITEM )