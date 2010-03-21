

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "pistol"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "9mm Combine Sidearm"			
	SWEP.Author				= "Clark"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= ""
	SWEP.ViewModelFOV       = 54
	SWEP.DrawCrosshair      = false
	
	killicon.AddFont( "weapon_9mm", "CSKillIcons", SWEP.IconLetter, Color( 0, 0, 0, 255 ) )
	
end


SWEP.Base				= "base"
SWEP.ViewModelFlip      = false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "weapons/pistol/pistol_fire3.wav" )
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 16
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.06
SWEP.Primary.ClipSize		= 18
SWEP.Primary.Delay			= 0.17
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

//SWEP.IronSightsPos = Vector (-5.5842, -15.513, 3.9776)
//SWEP.IronSightsAng = Vector (0.3937, -0.7367, 2.1391)

SWEP.IronSightsPos = Vector (-5.7552, -11.2132, 3.6315)
SWEP.IronSightsAng = Vector (1.4709, -1.1635, 1.5261)


function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end
