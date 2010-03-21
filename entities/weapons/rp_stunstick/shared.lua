if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.IconLetter = "m"
end

SWEP.Base = "base"

SWEP.PrintName			= "StunStick"
SWEP.Author				= "Clark"
SWEP.Instructions = "Left click to knockout a player"
	
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_stunstick.mdl"
SWEP.WorldModel			= "models/weapons/w_stunbaton.mdl"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Primary.ClipSize		= - 1
SWEP.Primary.Delay			= 1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= - 1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( "melee" )
	end
	
	self.HitSounds = {
		Sound( "weapons/stunstick/stunstick_fleshhit2.wav" ),
		Sound( "weapons/stunstick/stunstick_impact2.wav" ),
		Sound( "weapons/stunstick/stunstick_fleshhit1.wav" )
	}
	
	self.SwingSounds = {
		Sound( "weapons/stunstick/stunstick_swing1.wav" ),
		Sound( "weapons/stunstick/stunstick_swing2.wav" )
	}
end

function SWEP:PrimaryAttack()
	if ( CurTime() < self.Primary.Delay	) then return end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

	self.Primary.Delay = CurTime() + 1

	local tr = self.Owner:EyeTrace( 90 )

	if( tr.Hit or tr.Entity:IsValid() ) then
		if ( tr.Entity:IsPlayer() ) then
			local bullet = {}
			bullet.Num = 1
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( 0, 0, 0 )
			bullet.Tracer = 0
			bullet.Force = 54
			bullet.Damage = math.random( 1, 6 )
			self.Owner:FireBullets( bullet )
		end
		
		if( SERVER ) then
			if( tr.Entity:IsValid() ) then
				local norm = ( tr.Entity:GetPos() - self.Owner:GetPos() ):Normalize()
				local push = 8000 * norm
				
				if( tr.Entity:IsPlayer() ) then
					push = 100 * norm
					tr.Entity:SetVelocity( push )
					if ( tr.Entity:Health() < 30 and tr.Entity:Health() > 6 ) then
						tr.Entity:KnockOutPlayer( 40 )
					end
				else
					tr.Entity:GetPhysicsObject():ApplyForceOffset( push, tr.HitPos )
				end
			end
		end
		self.Weapon:EmitSound( self.HitSounds[ math.random( 1, #self.HitSounds ) ] )
	else
		self.Weapon:EmitSound( self.SwingSounds[ math.random( 1, #self.SwingSounds ) ] )
	end
end

function SWEP:SecondaryAttack()
end