

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "AR1 Special Pulse Rifle"			
	SWEP.Author				= "Clark"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= ""
	SWEP.ViewModelFOV       = 55
	SWEP.DrawCrosshair      = false

	killicon.AddFont( "weapon_ar1", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end


SWEP.Base				= "base"
SWEP.ViewModelFlip      = false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "weapons/ar1/ar1_dist2.wav" )
SWEP.Primary.Recoil			= 0.34
SWEP.Primary.Damage			= 16
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 4
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

//SWEP.IronSightsPos = Vector (-5.9198, -10.5868, 2.3849)
//SWEP.IronSightsAng = Vector (-3.2677, -1.7958, -0.9744)

SWEP.IronSightsPos = Vector (-5.9041, -8.2975, 2.0569)
SWEP.IronSightsAng = Vector (1.4211, -0.7471, 0.2709)




function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end
