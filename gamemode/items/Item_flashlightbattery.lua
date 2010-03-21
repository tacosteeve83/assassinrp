local ITEM = { }

ITEM.Name = "Flashlight Battery"
ITEM.UniqueID = "flashlightbattery"
ITEM.Description = "You need it to turn your flashlight on"
ITEM.Model = "models/Items/combine_rifle_ammo01.mdl"
ITEM.Price = 25
ITEM.Business = false
ITEM.CWU = true
ITEM.UseAble = false
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	end
end

RegisterItem( ITEM )