if SERVER then AddCSLuaFile("shared.lua") end

if CLIENT then
	SWEP.PrintName = "Battering Ram"
	SWEP.Slot = 5
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Clark"
SWEP.Instructions = "Left click to break open doors.\nRight click to close and lock."
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.AnimPrefix = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = 0     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false     -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""

/*---------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("rpg") end
end

/*---------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if CLIENT then return end

	local trace = self.Owner:GetEyeTrace()

	if ( not ValidEntity( trace.Entity ) or not trace.Entity:IsDoor() ) then
		return
	end

	if (trace.Entity:IsDoor() and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 45) then
		return
	end
	
	self.Owner:EmitSound(self.Sound)

	if trace.Entity:IsDoor() then
		trace.Entity:Fire("unlock", "", .5)
		trace.Entity:Fire("open", "", .6)
	end

	self.Owner:ViewPunch(Angle(-10, math.random(-5, 5), 0))
	self.Weapon:SetNextPrimaryFire(CurTime() + 2.5)
end

/*---------------------------------------------------------
Name: SWEP:SecondaryAttack()
Desc: +attack2 has been pressed
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if CLIENT then return end

	local trace = self.Owner:GetEyeTrace()

	if ( not ValidEntity( trace.Entity ) or not trace.Entity:IsDoor() ) then
		return
	end

	if (trace.Entity:IsDoor() and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 45) then
		return
	end
	
	self.Owner:EmitSound(self.Sound)

	if trace.Entity:IsDoor() then
		trace.Entity:Fire("close", "", 1.5)
		trace.Entity:Fire("lock", "", 1.6)
	end

	self.Owner:ViewPunch(Angle(-10, math.random(-5, 5), 0))
	self.Weapon:SetNextPrimaryFire(CurTime() + 2.5)
end
