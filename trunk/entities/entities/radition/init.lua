AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS)
	self.Entity:SetSolid( SOLID_VPHYSICS)
	self:AddDamage(15)

	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
	end
	
end

function ENT:Touch( hitEnt )
if hitEnt:GetModel() == '' then
end
	if hitEnt:IsValid() and hitEnt:IsPlayer() then
		hitEnt:SetHealth( 10 )
		hitEnt:ChatPrint("LOL U DED")
	end
end
