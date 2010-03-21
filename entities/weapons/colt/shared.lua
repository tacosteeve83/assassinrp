

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "pistol"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= ".357 Combine Sidearm"			
	SWEP.Author				= "Clark"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= ""
	SWEP.ViewModelFOV       = 60
	
	killicon.AddFont( "weapon_357", "CSKillIcons", SWEP.IconLetter, Color( 0, 0, 0, 255 ) )
	
end


SWEP.Base				= "base"
SWEP.ViewModelFlip      = false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_357.Single" )
SWEP.Primary.Recoil			= 0.9
SWEP.Primary.Damage			= 79
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.035
SWEP.Primary.ClipSize		= 6
SWEP.Primary.Delay			= 0.8
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 3
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector (-5.6519, -11.3595, 2.2513)
SWEP.IronSightsAng = Vector (1.4349, -0.083, 0.5996)


function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end