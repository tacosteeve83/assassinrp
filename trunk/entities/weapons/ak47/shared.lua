if ( SERVER ) then

AddCSLuaFile( "shared.lua" )

SWEP.HoldType= "smg1"

end

if ( CLIENT ) then

SWEP.PrintName= "AK47"
SWEP.Author		= "Clark";
SWEP.Slot = 2;
SWEP.SlotPos = 2;
SWEP.ViewModelFOV = 60;
SWEP.ViewModelFlip = true
SWEP.DrawCrosshair = false;

end


SWEP.Base= "base"

SWEP.Spawnable= false
SWEP.AdminSpawnable= true

SWEP.ViewModelFOV = 65

SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl";
SWEP.ViewModel = "models/weapons/v_rif_ak47.mdl";

SWEP.Weight= 6
SWEP.AutoSwitchFrom= false

SWEP.Primary.Sound = Sound( "Weapon_AK47.Single" );
SWEP.Primary.Recoil= 0.5
SWEP.Primary.Damage= 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = 30
SWEP.Primary.Delay = 0.07
SWEP.Primary.DefaultClip = 31
SWEP.Primary.Automatic= true
SWEP.Primary.Ammo= "smg1"

SWEP.IronSightPos = Vector( 6.05, 2.4, -4.0 );
SWEP.IronSightAng = Vector( 2.7, 0.0, 0.0 );

function SWEP:DrawHUD()
end
