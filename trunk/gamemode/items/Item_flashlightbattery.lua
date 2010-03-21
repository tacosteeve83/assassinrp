local ITEM = { }

ITEM.Name = "Flashlight Battery"
ITEM.UniqueID = "flashlightbattery"
ITEM.Description = "You need it to turn your flashlight on"
ITEM.Model = "models/Items/combine_rifle_ammo01.mdl"
ITEM.Price = 10
ITEM.Business = true
ITEM.CWU = true
ITEM.UseAble = false

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:Give( "flashlight1" )
	end
end

RegisterItem( ITEM )