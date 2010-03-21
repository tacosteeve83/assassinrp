if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "w"
end
SWEP.Base = "base"

SWEP.PrintName			= "Pat Down"			
SWEP.Author				= "Clark"
SWEP.Instructions = "Left click to patdown a player, player must be tied!"
	
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_fists.mdl"
SWEP.WorldModel			= "models/weapons/w_fists.mdl"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Primary.ClipSize		= - 1
SWEP.Primary.Delay			= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= - 1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= ""

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( "normal" )
	end
end

function SWEP:Deploy()
	if( SERVER ) then
		self.Owner:DrawViewModel( false )
		self.Owner:DrawWorldModel( false )
	end
end

local Contraband = 
{
	"radio",
	"weapon_mp7",
	"weapon_crowbar",
	"weapon_rpg",
	"weapon_357",
	"combine_shotty",
	"combine_ar2",
	"combine_9mm"
}

function SWEP:PrimaryAttack()
	if ( CurTime() < self.Primary.Delay	) then return end

	self.Primary.Delay = CurTime() + 1
	
	local trace = { }
	trace.start = self.Owner:EyePos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * 80
	trace.filter = self.Owner

	local tr = util.TraceLine( trace )
	
	if( tr.Hit or tr.Entity:IsValid() ) then
		if( SERVER ) then
			if( tr.Entity:IsPlayer() ) then
				if ( !tr.Entity.Tied ) then
					self.Owner:PrintChat( "Target is not tied!", false )
					return
				else
					for k, v in pairs( Contraband ) do
						if ( tr.Entity:HasItem( tostring( v ) ) ) then
							self.Owner:PrintChat( "Searching Target: ... Found Contraband items!", false )
							return
						else
							self.Owner:PrintChat( "Searching Target: ... Clean of contraband items.", false )
							return
						end
					end
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
end
