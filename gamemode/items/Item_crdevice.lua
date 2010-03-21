local ITEM = { }

ITEM.Name = "CR Device"
ITEM.UniqueID = "crdevice"
ITEM.Description = "Used to call for help."
ITEM.Model = "models/alyx_EmpTool_prop.mdl"
ITEM.Price = 10
ITEM.Business = false
ITEM.BlackMarket = false
ITEM.UU = true
ITEM.UseAble = false

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	end
end

RegisterItem( ITEM )