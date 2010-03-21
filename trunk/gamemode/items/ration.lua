local ITEM = { }

ITEM.Name = "Ration"
ITEM.UniqueID = "r09239830428"
ITEM.Description = "Contains some food and money."
ITEM.Model = "models/weapons/w_package.mdl"
ITEM.Price = 120
ITEM.Business = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		if ply:IsCombine() then
			ply:GiveItem( "r09239830428", 1 )
			return false
		else
			ply:SetNWInt( "Credits", ply:GetNWInt( "Credits" ) + 120 )
			ply:PrintChat( "Milk and Beans where added to your inventory", false )
			ply:GiveItem( "beans", 1 )
			ply:GiveItem( "milk", 1 )
		end
	end
end

RegisterItem( ITEM )