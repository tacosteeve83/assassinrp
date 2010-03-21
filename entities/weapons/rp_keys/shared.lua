if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.Slot				= 0
	SWEP.SlotPos			= 2
	SWEP.DrawCrosshair      = false
	SWEP.IconLetter = ""
	SWEP.DrawAmmo = false
end

SWEP.Base = "base"

SWEP.PrintName			= "Keys"
SWEP.Author				= "Clark"
SWEP.Instructions = "Left click to lock your door.\nRight click to unlock your door."
	
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_fists.mdl"
SWEP.WorldModel			= "models/weapons/w_fists.mdl"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Primary.Sound = "doors/door_latch1.wav"
SWEP.Primary.ClipSize		= - 1
SWEP.Primary.Delay			= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.Secondary.Sound = "doors/door_latch3.wav"
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
	
	local tr = self.Owner:EyeTrace( 80 )

	if ( SERVER ) then
		if ( tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
			if ( tr.Entity.Owners == self.Owner ) then
				tr.Entity:Fire( "lock", "", 0 )
				self.Owner:EmitSound( self.Primary.Sound )
			else
				self.Owner:PrintChat( "You do not own this door!", false )
				return
			end
		end
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )
	
	local tr = self.Owner:EyeTrace( 80 )
	
	if ( SERVER ) then
		if ( tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
			if ( tr.Entity.Owners == self.Owner ) then
				tr.Entity:Fire( "unlock", "", 0 )
				self.Owner:EmitSound( self.Secondary.Sound )
			else
				self.Owner:PrintChat( "You do not own this door!", false )
				return
			end
		end
	end
end
