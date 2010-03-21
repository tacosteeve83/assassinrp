

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "ar2"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "AR2 Heavy Pulse Machine Gun"			
	SWEP.Author				= "Clark"
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

SWEP.Primary.Sound			= Sound( "weapons/ar1/ar1_dist2.wav" )
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 11
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ClipSize		= 50
SWEP.Primary.Delay			= 0.06
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 4
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector (-5.667, -1.4726, 2.2318)
SWEP.IronSightsAng = Vector (-1.657, -0.6232, -1.625)


function SWEP:Initialize()

	if( SERVER ) then
	
		self:SetWeaponHoldType( "ar2" );
	
	end
	
	
	RoflSounds = {
	Sound( "weapons/ar1/ar1_dist.wav" ),
	Sound( "weapons/ar1/ar2_dist.wav" ) };

end


function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end