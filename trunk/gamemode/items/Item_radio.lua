local ITEM = { }

ITEM.Name = "Radio"
ITEM.UniqueID = "radio"
ITEM.Description = "A radio"
ITEM.Model = "models/alyx_EmpTool_prop.mdl"
ITEM.Price = 25
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:ConCommand( "RadioMenu" )
	end
end

RegisterItem( ITEM )