if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName = "Hands"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.IconLetter = ""
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Base = "base";

SWEP.Author			= "Clark"
SWEP.Instructions	= "Left Click - Hit someone.\nRight Click - Knock on doors."
SWEP.NotHolsterAnim = ACT_HL2MP_IDLE

SWEP.ViewModel = Model( "models/weapons/v_fists.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_fists.mdl" );

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "rpg"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""

SWEP.IronSightPos = Vector( 0, 6.2, -8.0 );
SWEP.IronSightAng = Vector( -4, 0, 0.0 );
SWEP.NoIronSightFovChange = true;
SWEP.NoIronSightAttack = true;

/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( "ar2" );
	end

	self.HitSounds = 
	{
		Sound( "npc/vort/foot_hit.wav" ),
		Sound( "weapons/crossbow/hitbod1.wav" ),
		Sound( "weapons/crossbow/hitbod2.wav" )
	}
	
	self.SwingSounds = 
	{
		Sound( "npc/vort/claw_swing1.wav" ),
		Sound( "npc/vort/claw_swing2.wav" )
	}
end


/*---------------------------------------------------------
   --Name: SWEP:Precache( )
   --Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
  	if( self.Owner:KeyDown( IN_SPEED ) and self.Owner:GetVelocity():Length() >= 140 ) then return; end
  	
  	local tr = self.Owner:EyeTrace( 60 )
  	
  	if( self.Owner:GetNWInt( "holstered" ) == 0 ) then
  
	if ( self.Weapon:GetNWBool( "ironsights" ) ) then return; end

	self.Weapon:EmitSound( self.SwingSounds[ math.random( 1, #self.SwingSounds ) ] )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.4 )
	
	if ( tr.Entity:IsValid() ) then
		local norm = ( tr.Entity:GetPos() - self.Owner:GetPos() ):Normalize()
		local push = 2000 * norm
		if ( SERVER ) then
			if ( tr.Entity:IsPlayer() ) then
				push = 50 * norm
				tr.Entity:SetVelocity( push )
				if ( tr.Entity:Health() < 15 ) then
					tr.Entity:KnockOutPlayer( 20 )
				end
			else
				tr.Entity:GetPhysicsObject():ApplyForceOffset( push, tr.HitPos )
			end
		end
		if ( tr.Hit or tr.HitWorld ) then
			self.Weapon:EmitSound( self.HitSounds[ math.random( 1, #self.HitSounds ) ] )
		end
	end
end
end

 
function SWEP:Reload()
end

SWEP.KnockDelay	= 0.25
function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + self.KnockDelay )
	
	local tr = self.Owner:GetEyeTrace()
	
	if ( self.Owner:GetShootPos():Distance( tr.HitPos ) <= 54 ) then
		if( tr.Entity:IsValid() and string.find( tr.Entity:GetClass(), "_door" ) ) then
			self.Weapon:EmitSound( "physics/wood/wood_crate_impact_hard2.wav" )
		end
	end
end
  