local ITEM = { }

ITEM.Name = "Box of Vodka"
ITEM.UniqueID = "vodkabox"
ITEM.Description = "Box containing six vodka bottles."
ITEM.Model = "models/props/CS_militia/caseofbeer01.mdl"
ITEM.Price = 150    
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
	ply:GiveItem( "vodka", 6 );
	end
end

RegisterItem( ITEM )