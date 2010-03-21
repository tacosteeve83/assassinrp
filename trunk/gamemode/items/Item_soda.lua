local ITEM = { }

ITEM.Name = "Soda"
ITEM.UniqueID = "soda"
ITEM.Description = "A can of soda"
ITEM.Model = "models/props_junk/PopCan01a.mdl"
ITEM.Price = 20
ITEM.CWU = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:SetHealth( ply:Health() + 10 )
	end
end

RegisterItem( ITEM )