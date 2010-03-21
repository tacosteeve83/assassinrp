local EMeta = FindMetaTable( "Entity" )

local DoorTable = { "func_door", "func_door_rotating", "prop_door_rotating" }

function EMeta:IsDoor()
	local Class = self:GetClass()
	
	for k, v in pairs( DoorTable ) do
		if ( Class == v ) then
			return true
		end
	end
	
	return false
end

function EMeta:IsItem()
	local Class = self:GetClass()
	
	if ( Class == "rp_item" ) then
		return true
	else
		return false
	end
end

EMeta = nil
