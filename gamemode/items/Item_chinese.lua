local ITEM = { }

ITEM.Name = "Take out"
ITEM.UniqueID = "chinese"
ITEM.Description = "A box of chinese takeout"
ITEM.Model = "models/props_junk/garbage_takeoutcarton001a.mdl"
ITEM.Price = 20
ITEM.Business = false
ITEM.CWU = true
ITEM.UseAble = true
ITEM.Weight = 2

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		ply:SetHealth( ply:Health() + 20 )
	end
end

RegisterItem( ITEM )