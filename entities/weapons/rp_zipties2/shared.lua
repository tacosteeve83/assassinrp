if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.Slot				= 3
	SWEP.SlotPos			= 2
	SWEP.IconLetter			= "w"
end
SWEP.Base = "base"

SWEP.PrintName			= "ZipTies"			
SWEP.Author				= "Clark"
SWEP.Instructions = "Left click to tie a player.\nRight click to untie a player."
	
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
			if( tr.Entity:IsValid() ) then
				if( tr.Entity:IsPlayer() ) then
					tr.Entity:SetTied( true )
					self.Owner:PrintChat( "Tied target.", false )
				end
			end
		end
	end
	self:Remove()
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )
	
	local tr = self.Owner:GetEyeTrace()
	
	if ( SERVER ) then
		if ( self.Owner:GetShootPos():Distance( tr.HitPos ) <= 54 ) then
			if( tr.Entity:IsValid() and tr.Entity:IsPlayer() ) then
				tr.Entity:SetTied( false )
				self.Owner:PrintChat( "Untied target.", false )
			end
		end
	end
	self:Remove()
end

