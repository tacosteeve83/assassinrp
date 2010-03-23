local ITEM = { }

ITEM.Name = "Flashlight"
ITEM.UniqueID = "flashlightbattery"
ITEM.Description = "Assists in seeing things"
ITEM.Model = "models/lagmite/lagmite.mdl"
ITEM.Price = 25
ITEM.Business = true
ITEM.CWU = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	ply:Give( "flashlight" )
	end
end

RegisterItem( ITEM )