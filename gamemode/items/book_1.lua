local ITEM = { }

ITEM.Name = "Anatomy of Antlion"
ITEM.UniqueID = "Book_an_aa"
ITEM.Description = "A book all about the Antlion Anatomy."
ITEM.Model = "models/props_lab/binderredlabel.mdl"
ITEM.Price = 600
ITEM.Business = false
ITEM.CWU = true
ITEM.Book = true
ITEM.UseAble = true
ITEM.Weight = 1

if ( SERVER ) then
function ITEM:UseEnt( ply )
	umsg.Start("AntlionAnatomy", ply)
	umsg.End()
	end
end
RegisterItem( ITEM )
