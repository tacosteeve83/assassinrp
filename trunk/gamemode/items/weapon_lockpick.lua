local ITEM = { }

ITEM.Name = "Lockpick"
ITEM.UniqueID = "lockpick"
ITEM.Description = "Unlock a door?"
ITEM.Model = "models/weapons/w_crowbar.mdl"
ITEM.Price = 120
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "lockpick" )
	end
end

RegisterItem( ITEM )