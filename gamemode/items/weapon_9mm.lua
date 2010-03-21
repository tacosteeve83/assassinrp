local ITEM = { }

ITEM.Name = "9mm Pistol"
ITEM.UniqueID = "9mm"
ITEM.Description = "Very common pistol used by UU."
ITEM.Model = "models/weapons/w_pistol.mdl"
ITEM.Price = 400
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "9mm" )
	end
end

RegisterItem( ITEM )