

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "ar2"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Combine Roit Shotgun"
	SWEP.Author				= "Clark"
	SWEP.Slot				= 5
	SWEP.SlotPos			= 5
	SWEP.IconLetter			= ""
	SWEP.ViewModelFOV		= 83
	SWEP.ViewModelFlip		= true
	SWEP.DrawCrosshair      = false

end


SWEP.Base				= "base"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_shot_m3super90.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_m3super90.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil			= 1.2
SWEP.Primary.Damage			= 12
SWEP.Primary.NumShots		= 12
SWEP.Primary.Cone			= 0.1
SWEP.Primary.ClipSize		= 12
SWEP.Primary.Delay			= 1
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightPos = Vector( 5.8, 2.2, -2.0 );
SWEP.IronSightAng = Vector( 2.0, 0.0, 0.0 );

function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end


/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
	
	--if ( CLIENT ) then return end
	
	self:SetIronsights( false )
	
	-- Already reloading
	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then return end
	
	-- Start reloading if we can
	if ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		
		self.Weapon:SetNetworkedBool( "reloading", true )
		self.Weapon:SetVar( "reloadtimer", CurTime() + 0.6 )
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
		
	end

end

/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()


	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then
	
		if ( self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() ) then
			
			-- Finsished reload -
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SetNetworkedBool( "reloading", false )
				return
			end
			
			-- Next cycle
			self.Weapon:SetVar( "reloadtimer", CurTime() + 0.6 )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			
			-- Add ammo
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
			self.Weapon:EmitSound( "weapons/shotgun/shotgun_reload3.wav" )	
			
			
			-- Finish filling, final pump
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			else
			
			end
			
		end
	
	end

end

function SWEP:PrimaryAttack()

	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	if ( !self:CanPrimaryAttack() ) then return end
	
	-- Play shoot sound
	self.Weapon:EmitSound( self.Primary.Sound )
	
	-- Shoot the bullet
	self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	if ( self.Owner:IsNPC() ) then return end
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( math.Rand(-5.7,-2.4) * self.Primary.Recoil, math.Rand(-0.2,0.3) *self.Primary.Recoil, 0 ) )
	
	-- In singleplayer this function doesn't get called on the client, so we use a networked float
	-- to send the last shoot time. In multiplayer this is predicted clientside so we don't need to 
	-- send the float.
	if ( (SinglePlayer() && SERVER) || CLIENT ) then
		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )

	local tr = self.Owner:EyeTrace( 90 )

	if( tr.Hit or tr.Entity:IsValid() ) then
		if ( tr.Entity:IsPlayer() ) then
			local bullet = {}
			bullet.Num = 1
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( 0, 0, 0 )
			bullet.Tracer = 0
			bullet.Force = 54
			bullet.Damage = math.random( 1, 6 )
			self.Owner:FireBullets( bullet )
		end
		
		if( SERVER ) then
			if( tr.Entity:IsValid() ) then
				local norm = ( tr.Entity:GetPos() - self.Owner:GetPos() ):Normalize()
				local push = 8000 * norm
				
				if( tr.Entity:IsPlayer() ) then
					push = 100 * norm
					tr.Entity:SetVelocity( push )
					if ( tr.Entity:Health() < 30 and tr.Entity:Health() > 6 ) then
						tr.Entity:KnockOutPlayer( 40 )
					end
				else
					tr.Entity:GetPhysicsObject():ApplyForceOffset( push, tr.HitPos )
				end
			end
		end
	end
end
end
