local ITEM = { }

ITEM.Name = "Box of Vodka"
ITEM.UniqueID = "vodkabox"
ITEM.Description = "Box containing four vodka bottles."
ITEM.Model = "models/props/CS_militia/caseofbeer01.mdl"
ITEM.Price = 140    
ITEM.Business = true
ITEM.BlackMarket = true
ITEM.UseAble = true
ITEM.Weight = 5

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	ply:GiveItem( "vodka", 4 );
	end
end

RegisterItem( ITEM )