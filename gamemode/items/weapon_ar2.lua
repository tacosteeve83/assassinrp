local ITEM = { }

ITEM.Name = "AR2"
ITEM.UniqueID = "ar2"
ITEM.Description = "Heavy rifle used by UU."
ITEM.Model = "models/weapons/w_irifle.mdl"
ITEM.Price = 600
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true
ITEM.Weight = 3

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "ar2" )
	end
end

RegisterItem( ITEM )