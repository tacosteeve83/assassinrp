local ITEM = { }

ITEM.Name = "Shotgun Ammo"
ITEM.UniqueID = "ammo_shotgun"
ITEM.Description = "50 Buck Shot Shells."
ITEM.Model = "models/Items/BoxBuckshot.mdl"
ITEM.Price = 75
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true
ITEM.Weight = 5

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:GiveAmmo( 50,"Buckshot" )
	end
end

RegisterItem( ITEM )