local ITEM = { }

ITEM.Name = "Crowbar"
ITEM.UniqueID = "crowbar"
ITEM.Description = "Aim to the head!"
ITEM.Model = "models/weapons/w_crowbar.mdl"
ITEM.Price = 50
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "weapon_crowbar" )
	end
end

RegisterItem( ITEM )