
SWEP.Author				= "Clark"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= ""
SWEP.WorldModel				= ""

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Delay			= 1

SWEP.Secondary.ClipSize		= -1  
SWEP.Secondary.DefaultClip	= -1  
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none" 

function SWEP:Initialize( )
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
end

function SWEP:Think()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack( )
	
	local tr = self.Owner:GetEyeTrace( )
	if ( tr.Entity:GetClass( ) == "prop_door_rotating" && tr.Entity:GetPos( ):Distance( self.Owner:GetPos( ) ) < 100 ) then
		tr.Entity:EmitSound( "npc/turret_floor/deploy.wav" )
		
		if ( SERVER ) then
			local ent = ents.Create( "prop_dynamic_override" )
			ent:SetModel( "models/Items/combine_rifle_ammo01.mdl" ) 
			ent:SetPos( tr.HitPos )
			ent:SetAngles( tr.Entity:GetAngles( ) + Angle( 0, 90, 0 ) )
			ent:SetMoveType( MOVETYPE_NONE )
			ent:SetSolid( SOLID_VPHYSICS )
			ent:SetParent( tr.Entity )
			ent:Spawn( ) 

			timer.Simple( 1, function( ) ent:EmitSound( "hl1/fvox/beep.wav" ) end )
			timer.Simple( 2, function( ) ent:EmitSound( "hl1/fvox/beep.wav" ) end )
			timer.Simple( 3, function( ) ent:EmitSound( "hl1/fvox/beep.wav" ) end )
			timer.Simple( 4, function( ) ent:EmitSound( "hl1/fvox/beep.wav" ) end )
			timer.Simple( 5, function( ) ent:EmitSound( "hl1/fvox/beep.wav" ) end )
			timer.Simple( 5, function( ) 

			local door = ents.Create( "prop_physics" )
				door:SetModel( tr.Entity:GetModel( ) )
				door:SetPos( tr.Entity:GetPos( ) )
				door:SetAngles( tr.Entity:GetAngles( ) )
				door:SetSkin( tr.Entity:GetSkin( ) )
				door:Spawn( ) 
				door:GetPhysicsObject( ):SetVelocity( self.Owner:GetPos( ) + self.Owner:GetForward( ) * 10373 )
			local explode = ents.Create( "env_explosion" )
				explode:SetKeyValue( "spawnflags", 128 )
				explode:SetPos( tr.Entity:GetPos( ) )
				explode:Spawn( )
				explode:Fire( "explode", "", 0 )
				ent:Remove( )
				tr.Entity:Remove( )
			end )
		end
	end
	self:TakePrimaryAmmo( 1 )
end


function SWEP:SecondaryAttack( )
end 

function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end
