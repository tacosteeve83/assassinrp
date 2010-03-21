local ITEM = { }

ITEM.Name = "Machine Pistol 7"
ITEM.UniqueID = "mp7"
ITEM.Description = "Common sub machine gun."
ITEM.Model = "models/weapons/w_smg1.mdl"
ITEM.Price = 500
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UU = true
ITEM.UseAble = true
ITEM.Weight = 3

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "mp7" )
	end
end

RegisterItem( ITEM )