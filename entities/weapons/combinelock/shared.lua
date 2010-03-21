SWEP.PrintName        	= "Combine Lock"
SWEP.Author				= "Clark"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""

SWEP.Slot				= 3  
SWEP.SlotPos			= 1   
SWEP.DrawAmmo			= false   
SWEP.DrawCrosshair		= true 

SWEP.Weight		= 5   
SWEP.AutoSwitchTo	= false   
SWEP.AutoSwitchFrom	= false  
SWEP.HoldType = "normal"

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

function SWEP:DrawHUD( )
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
			tr.Entity:SetNWBool( "Owned", false )
			tr.Entity:SetNWBool( "Owned", true )
			tr.Entity:SetNWString( "doorname", "Combine Lock" )
			tr.Entity:Fire( "lock", "", 1 )
			tr.Entity:Fire( "lock", "", 10 )
			tr.Entity:Fire( "lock", "", 60 )

			local ent = ents.Create( "prop_dynamic_override" )
			ent:SetModel( "models/props_combine/combine_lock01.mdl" ) 
			ent:SetPos( tr.HitPos )
			ent:SetAngles( tr.Entity:GetAngles( ) + Angle( 0, 90, 0 ) )
			ent:SetMoveType( MOVETYPE_NONE )
			ent:SetSolid( SOLID_VPHYSICS )
			ent:SetParent( tr.Entity )
			ent:Spawn() 
		end
	end
end

function SWEP:SecondaryAttack( )
	local tr = self.Owner:GetEyeTrace( )
	if ( tr.Entity:GetClass( ) == "prop_door_rotating" && tr.Entity:GetPos( ):Distance( self.Owner:GetPos( ) ) < 100 ) then
		tr.Entity:EmitSound( "npc/turret_floor/deploy.wav" )
		if ( SERVER ) then
			tr.Entity:SetNWBool( "Owned", false )
			tr.Entity:SetNWString( "doorname", "" )
			tr.Entity:Fire( "unlock", "", 1 )
		end
	end
end

function SWEP:Deploy() 
 self.Owner:ConCommand("toggleholster\n");
 self.Owner:ConCommand("toggleholster\n"); 
end
