local PMeta = FindMetaTable( "Player" )

function PMeta:Nick()
	return self:GetNWString( "RPNick" )
end

function PMeta:EyeTrace( dis )
	local tr = {}
	tr.start = self:GetShootPos()
	tr.endpos = tr.start + ( self:GetCursorAimVector() * dis )
	tr.filter = self
	tr = util.TraceLine( tr )
	return tr
end 

function PMeta:PrintChat( msg, serverconsole )
	self:PrintMessage( HUD_PRINTTALK, msg )
	
	if ( SERVER ) then
		if ( serverconsole ) then
			Msg( msg .. "\n" )
		end
	end
end

function PMeta:PrintConsole( msg, serverconsole )
	self:PrintMessage( HUD_PRINTCONSOLE, msg )
	
	if ( SERVER ) then
		if ( serverconsole ) then
			Msg( msg .. "\n" )
		end
	end
end

function PMeta:PrintCenter( msg, serverconsole )
	self:PrintMessage( HUD_PRINTCENTER, msg )
	
	if ( SERVER ) then
		if ( serverconsole ) then
			Msg( msg .. "\n" )
		end
	end
end

-- Check if player is WM.
function PMeta:IsWM()
	local Team = self:Team()
	
	local WMTeamTable = { 2 }
	
	for k, v in pairs( WMTeamTable ) do
		if ( v == Team ) then
			return true
		end
	end
	
	return false
end

-- Check if player is Combine.
function PMeta:IsCombine()
	local Team = self:Team()
	
	local CombineTeamTable = { 4, 5, 6, 7, 8, 9, 10 }
	
	for k, v in pairs( CombineTeamTable ) do
		if ( v == Team ) then
			return true
		end
	end
	
	return false
end

-- Check if player is Combine but not the city admin.
function PMeta:IsCombine2()
	local Team = self:Team()
	
	local Combine2TeamTable = { 4, 5, 6, 7, 8, 9 }
	
	for k, v in pairs( Combine2TeamTable ) do
		if ( v == Team ) then
			return true
		end
	end
	
	return false
end

function PMeta:IsSprinting()   
   
   return self:KeyDown( IN_SPEED )  
   
end  

function PMeta:IsWalking()  
   
   return not self:KeyDown( IN_SPEED )  
   
end

function PMeta:IsWalking()  
   
   return not self:KeyDown( IN_SPEED )  
   
end

PMeta = nil
