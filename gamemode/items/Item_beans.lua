local ITEM = { }

ITEM.Name = "Beans"
ITEM.UniqueID = "beans"
ITEM.Description = "Pork and Beans, Eat it!"
ITEM.Model = "models/props_junk/garbage_metalcan001a.mdl"
ITEM.Price = 30
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		if ( ply:Health() > 0 and ply:Health() < 100 ) then
			ply:SetHealth( math.Clamp( ply:Health() + 10, 0, 100 ) )
		end
	end
end

RegisterItem( ITEM )