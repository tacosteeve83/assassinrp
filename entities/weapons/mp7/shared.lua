if ( SERVER ) then

AddCSLuaFile( "shared.lua" )

SWEP.HoldType= "smg"

end

if ( CLIENT ) then

SWEP.PrintName= "MP7 Sub Machine Gun"
SWEP.Author		= "Clark";
SWEP.Slot= 2
SWEP.SlotPos= 2
SWEP.IconLetter= "x"
SWEP.ViewModelFlip = false
SWEP.DrawCrosshair = false 

killicon.AddFont( "weapon_smg1", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )

end


SWEP.Base= "base"

SWEP.Spawnable= false
SWEP.AdminSpawnable= true

SWEP.ViewModelFOV			= 65
SWEP.ViewModel= "models/weapons/v_smg1.mdl"
SWEP.WorldModel= "models/weapons/w_smg1.mdl"

SWEP.Weight= 6
SWEP.AutoSwitchFrom= false

SWEP.Primary.Sound= Sound( "Weapon_smg1.Single" )
SWEP.Primary.Recoil= 0.6
SWEP.Primary.Damage= 13
SWEP.Primary.NumShots= 1
SWEP.Primary.Cone= 0.04
SWEP.Primary.ClipSize= 40
SWEP.Primary.Delay= 0.07
SWEP.Primary.DefaultClip= SWEP.Primary.ClipSize * 4
SWEP.Primary.Automatic= true
SWEP.Primary.Ammo= "smg1"

SWEP.IronSightsPos 		= Vector(  -6.44, -8, 2.55  )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )

function SWEP:DrawHUD() end


