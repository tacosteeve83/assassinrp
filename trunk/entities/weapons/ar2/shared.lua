

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "ar2"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "AR2 Combine Standard Pulse Rifle"			
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= ""
	SWEP.ViewModelFOV      = 64
	SWEP.DrawCrosshair      = false
	
	killicon.AddFont( "weapon_ar2", "CSKillIcons", SWEP.IconLetter, Color( 0, 0, 0, 255 ) )
	
end


SWEP.Base				= "base"
SWEP.ViewModelFlip		= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_AR2.Single" )
SWEP.Primary.Recoil			= 0.30
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.039
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.10
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 3
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

//SWEP.IronSightsPos = Vector (-5.9198, -10.5868, 2.3849)
//SWEP.IronSightsAng = Vector (-3.2677, -1.7958, -0.9744)

SWEP.IronSightsPos = Vector (-5.9041, -8.2975, 2.0569)
SWEP.IronSightsAng = Vector (1.4211, -0.7471, 0.2709)



function SWEP:Initialize()

	if( SERVER ) then
	
		self:SetWeaponHoldType( "ar2" );
	
	end
	
	
	RoflSounds = {
	Sound( "weapons/ar1/ar1_dist.wav" ),
	Sound( "weapons/ar1/ar2_dist.wav" ) };

end


SWEP.data = {}
SWEP.mode = "auto" //The starting firemode
SWEP.data.newclip = true //Do not change this.. lol

SWEP.data.semi = {}
SWEP.data.semi.Delay = .09
SWEP.data.semi.Cone = 0.01
SWEP.data.semi.ConeZoom = 0.009

SWEP.data.burst = {}
SWEP.data.burst.Delay = .3
SWEP.data.burst.Cone = 0.02
SWEP.data.burst.ConeZoom = 0.013
SWEP.data.burst.BurstDelay = .063
SWEP.data.burst.Shots = 3
SWEP.data.burst.Counter = 0
SWEP.data.burst.Timer = 0

SWEP.data.auto = {}
SWEP.data.auto.Delay = 0.001
SWEP.data.auto.Cone = 0.4
SWEP.data.auto.ConeZoom = 0


function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end