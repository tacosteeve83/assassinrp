if CLIENT then
	SWEP.PrintName = "Pickup"
	SWEP.Slot = 0
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.IconLetter = "m"
end

if SERVER then
	AddCSLuaFile( "shared.lua" )

	SWEP.Weight = 1
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false 
end

SWEP.Author				= "Clark"
SWEP.Purpose			= "Pickup stuff."
SWEP.Instructions			= "Left click - Toss/Shove object\nRight click - Pick up an object."

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_fists.mdl"
SWEP.WorldModel			= "models/weapons/w_fists.mdl"
SWEP.Holdtypecycle		= 0

SWEP.Primary.ClipSize		= - 1
SWEP.Primary.DefaultClip	= - 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= - 1
SWEP.Secondary.DefaultClip	= - 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

local PICKUP_DISTANCE = 65
local SHOVE_DISTANCE = 64

function SWEP:Reload()
end

function SWEP:Think()
	if !SERVER then return end

	local ply = self:GetOwner()
	if !ply or !ply:IsValid() then return end

	if ply:KeyPressed( IN_ATTACK ) then
		self.Pushing = true
	elseif ply:KeyReleased( IN_ATTACK) then
		self.Pushing = false
	end

	if self.Pushing then
		if self.Hold and self.Hold:IsValid() then
			local ent = self.Hold
			if !ent or !ent:IsValid() then return end
			local phys = ent:GetPhysicsObject()
			if !phys or !phys:IsValid() then return end
			self.Hold:Drop()
			local mass = phys:GetMass()
			local force = math.max( 0, 300 - mass * 0.01 )
			phys:ApplyForceCenter( ply:GetAimVector() * force )
		end

		local tr = self:GetOwner():GetEyeTrace()
		local ent = tr.Entity
		if !ent or !ent:IsValid() then return end
		local phys = ent:GetPhysicsObject()
		if !phys or !phys:IsValid() then return end

		if ( tr.StartPos - tr.HitPos ):Length() > SHOVE_DISTANCE then return end
		if ent:IsNPC() or ent:IsPlayer() or ent:IsVehicle() then return end

		local mass = phys:GetMass()
		local force = math.max( 0, 400 - mass * 0.01 )
		phys:ApplyForceOffset( tr.Normal * force, tr.HitPos )
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
	if !SERVER then return end
	if self.Pushing then return end

	if !self.Hold or !self.Hold:IsValid() then
		local tr = self:GetOwner():GetEyeTrace()
		local ent = tr.Entity
		local phys = ent:GetPhysicsObject()

		if ( tr.StartPos - tr.HitPos ):Length() > PICKUP_DISTANCE then return end
		if !ent or !ent:IsValid() or !phys or !phys:IsValid() then return end
		if !phys:IsMoveable() or ent:IsNPC() or ent:IsPlayer() or ent:IsVehicle() then return end
		if phys:GetMass() > ( GetConVar( "physcannon_maxmass" ):GetInt() / 3 ) then return end

		self.Hold = ents.Create( "rp_pickupent" )
		self.Hold:Spawn()

		self.Hold:Setup( ent, self:GetOwner(), tr.HitPos )
	elseif self.Hold:IsValid() then
		self.Hold:Drop()
		self.Hold = nil
	end
end

function SWEP:OnRemove()
	if self.Hold and self.Hold:IsValid() then
		self.Hold:Drop()
		self.Hold = nil
	end
end

function SWEP:OnDrop()
	if self.Hold and self.Hold:IsValid() then
		self.Hold:Drop()
		self.Hold = nil
	end
end
