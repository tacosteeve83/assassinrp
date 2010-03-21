if ( SERVER ) then

AddCSLuaFile( "shared.lua" )

SWEP.HoldType= "smg`"

end

if ( CLIENT ) then

SWEP.PrintName= "MAC 10"
SWEP.Author		= "Clark";
SWEP.Slot= 2
SWEP.SlotPos= 2
SWEP.IconLetter= "x"
SWEP.ViewModelFlip = true
SWEP.DrawCrosshair = false 

killicon.AddFont( "weapon_smg1", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )

end


SWEP.Base = "base"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.ViewModelFOV = 54

SWEP.ViewModel = "models/weapons/v_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.Sound = Sound("Weapon_mac10.Single")
SWEP.Primary.Recoil = .5
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 25
SWEP.Primary.Delay = 0.09
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"

SWEP.IronSightsPos = Vector(6.7, -3, 3)
SWEP.IronSightsAng = Vector(0, 5, 5)

function SWEP:DrawHUD()
end

function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end
