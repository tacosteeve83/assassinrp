AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
end

function ENT:OnTakeDamage( dmg )
	self.Ent:TakeDamage( dmg:GetDamage(), dmg:GetAttacker(), dmg:GetInflictor() )
end

function ENT:Setup( ent, ply, hitpos )
	self.Holder = ply
	local phys = ent:GetPhysicsObject()

	if !phys or !phys:IsValid() then
		self:Remove()
		return
	end

	self.Ent = ent
	self.SavedPhys = phys:IsMoveable()
	self.SavedCollision = ent:GetCollisionGroup()
	local r, g, b, a = ent:GetColor()
	self.Color = Color( r, g, b, a )

	local ang, plyang = ent:GetAngles(), ply:GetAimVector():Angle()
	self.OffsetAngles = plyang-ang
	self.OriginalAngles = ang
	self.OffsetPos = ent:WorldToLocal( hitpos )

	//phys:EnableMotion( false )
	ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	//ent:SetColor( 0, 0, 0, 0 )

	self:SetModel( ent:GetModel() )
	self:SetPos( ent:GetPos() )
	self:SetAngles( ang )
	ent:SetParent( self )

	self:PhysicsInit( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass( 5 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
	end
	self:StartMotionController()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	local holder_ent = self
	ent:CallOnRemove( self:EntIndex().."_EntRemoveDrop", function() self:Drop() end )

	self.IsSetup = true
end

function ENT:Drop()
	if self.Ent and self.Ent:IsValid() then
		self.Ent:SetParent( nil )
		self.Ent:SetPos( self:GetPos() )
		self.Ent:SetAngles( self:GetAngles() )
		//self.Ent:SetColor( self.Color.r, self.Color.g, self.Color.b, self.Color.a )

		local phys_self = self:GetPhysicsObject()

		local phys = self.Ent:GetPhysicsObject()
		phys:EnableMotion( self.SavedPhys )
		self.Ent:SetCollisionGroup( self.SavedCollision )
		phys:Wake()
		phys:SetVelocity( phys_self:GetVelocity() )
		phys:AddAngleVelocity( phys_self:GetAngleVelocity() )

		self.Ent:RemoveCallOnRemove( self:EntIndex().."_EntRemoveDrop" )
	end

	self:Remove()
end

function ENT:PhysicsSimulate( phys, deltatime )
	if !self.IsSetup then return end

	local ply = self.Holder
	if !ply or !ply:IsValid() then
		if self.Ent and self.Ent:IsValid() then self.Ent:Remove() end
		self:Remove()
		return
	end

	local pos = self:GetPos()
	local plyang = ply:GetAimVector():Angle()
	local newang = plyang-self.OffsetAngles
	newang.p = self.OriginalAngles.p
	local obb_offset = pos - self:LocalToWorld( self.OffsetPos )
	
	local newpos = (ply:EyePos() + 50 * plyang:Forward()) + obb_offset
	if (pos-newpos):Length() > 72 then
		self:Drop()
		return
	end

	phys:Wake()

	self.ShadowParams = {}
	self.ShadowParams.secondstoarrive = deltatime
	self.ShadowParams.pos = newpos
	self.ShadowParams.angle = newang
	self.ShadowParams.maxangular = 5000
	self.ShadowParams.maxangulardamp = 100000
	self.ShadowParams.maxspeed = 1000000
	self.ShadowParams.maxspeeddamp = 100000
	self.ShadowParams.dampfactor = 0.8
	self.ShadowParams.teleportdistance = 0
	self.ShadowParams.deltatime = deltatime
	
	phys:ComputeShadowControl( self.ShadowParams )

	return SIM_NOTHING
end 