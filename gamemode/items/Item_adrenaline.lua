local ITEM = { }

ITEM.Name = "Adrenaline"
ITEM.UniqueID = "adrenaline"
ITEM.Description = "Adrenaline allows you run faster"
ITEM.Model = "models/katharsmodels/syringe_out/syringe_out.mdl"
ITEM.Price = 100
ITEM.Business = true
ITEM.BlackMarket = false
ITEM.UseAble = true

if ( SERVER ) then
	function ITEM:UseEnt( ply )
		local adrenalinetake = Sound("adrenaline/use.wav")
		local adrenalineend = Sound("vo/npc/Barney/ba_pain08.wav")
			timer.Create( "Take", 0.1, 1, function()
					ply:EmitSound( adrenalinetake )
end )
					ply:SetJumpPower( 300 )
					ply:SetRunSpeed( 700 )
					ply:SetWalkSpeed( 300 )
timer.Create( "AddHp", 0.1, 100, function()
		local health = ply:Health()
					ply:SetHealth( health + 1 )
end )
			timer.Create( "Wearoff", 20, 1, function()
					ply:SetJumpPower( 160 )
					ply:SetRunSpeed( 275 )
					ply:SetWalkSpeed( 175 )
					ply:EmitSound( adrenalineend )
		local health = ply:Health()
					ply:SetHealth( 50 )
		end )
	end
end

RegisterItem( ITEM )