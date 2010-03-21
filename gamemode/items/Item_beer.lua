local ITEM = { }

ITEM.Name = "Beer"
ITEM.UniqueID = "beer"
ITEM.Description = "A bottle of Beer"
ITEM.Model = "models/props_junk/garbage_glassbottle002a.mdl"
ITEM.Price = 15
ITEM.Business = false
ITEM.BlackMarket = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	umsg.Start( "Drug", self.Owner ) umsg.End()
	end
end

RegisterItem( ITEM )