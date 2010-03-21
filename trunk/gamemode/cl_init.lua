include( "vgui/cl_playermenu.lua" )
include( "vgui/cl_charcreatemenu.lua" )
include( "vgui/cl_radiomenu.lua" )
include( "vgui/cl_selectcharmenu.lua" )
include( "vgui/cl_dermaskin.lua" )
include( "vgui/cl_books.lua" )
include( "player_shared.lua" )
include( "teams.lua" )
include( "shared.lua" )
include( "entity_shared.lua" )
include( "cl_hud.lua" )
include( "cl_networking.lua" )
include( "combinevoices.lua" )

MapViewTable = { }
MapViewTable[ "rp_c18_v1" ] = { pos = Vector( 1105.632202, -2726.487061, 1057.354980 ), ang = Angle( 5.399988, -0.520028, 0.0000000 ) }
MapViewTable[ "aim_ag_texture2" ] = { pos = Vector( -206.224564, 729.176880, 182.949402 ), ang = Angle( 2.199999, 88.660126, 0.000000 ) }
MapViewTable[ "rp_city11_night" ] = { pos = Vector( -3550.375000, 109.531250, -424.343750 ), ang = Angle( 32.647984, -73.306175, 0.000000 ) }

--MapViewTable[ "rp_c18_v1" ] = { pos = Vector( 1105.632202, -2726.487061, 1057.354980 ), ang = Angle( 5.399988, -0.520028, 0.000000 ) } --Outside the train station
--MapViewTable[ "rp_c18_v1" ] = { pos = Vector( -59.515850, -665.427002, 946.041565 ), ang = Angle( 0.779991, 45.240040, 0.000000 ) } --CWU Warehouse Plaza
--MapViewTable[ "rp_c18_v1" ] = { pos = Vector( -904.418945, 1285.728271, 945.679565 ), ang = Angle( 1.439993, 179.440033, 0.000000 ) } -- Terminal
--MapViewTable[ "rp_c18_v1" ] = { pos = Vector( -1040.881836, -87.211716, 816.554993 ), ang = Angle( 0.999991, -179.900040, 0.000000 ) } -- The 45's Apartments

MapView = true

function GM:Initialize( )
	self.BaseClass:Initialize()
end

function GM:StartChat()
	LocalPlayer():ConCommand( "eng_chatopen" )
end

function GM:FinishChat()
	LocalPlayer():ConCommand( "eng_chatclose" )
end

function DeathView( ply, origin, angles, fov )
	if ( ply:Alive() ) then return end
	
	local Ragdoll = ply:GetRagdollEntity()
	if ( !Ragdoll or !Ragdoll:IsValid() ) then return end
	
	local EyePos = Ragdoll:GetAttachment( Ragdoll:LookupAttachment( "eyes" ) )
	local NView = { origin = EyePos.Pos, angles = EyePos.Ang, fov = 90 }
	
	return NView
end
hook.Add( "CalcView", "DeathView", DeathView )

function MapViewThing( ply, origin, angles, fov )
	if ( MapView ) then
		if ( MapViewTable[ game.GetMap() ] ) then
			View = { origin = MapViewTable[ game.GetMap() ].pos, angles = MapViewTable[ game.GetMap() ].ang }
			return View
		end
	end
end
hook.Add( "CalcView", "MapViewThing", MapViewThing )

function GM:ForceDermaSkin()
	return "KIWISKINSkin" 
end

-- Whatev copypasta.
function GM:GetScreenCenterBounce( bounce )
	return ScrW() / 2, ( ScrH() / 2 ) + 32 + ( math.sin( CurTime() ) * ( bounce or 8 ) )
end

local PCalcT = {}
PCalcT.VS 	 = 0
PCalcT.WT 	 = 0
PCalcT.Air	 = 0

function ShakeView(ply, origin, angles, fov)
	if ply:GetMoveType() == 8 then
		return
	elseif (not ply:IsOnGround()) or ply:InVehicle() then --hes in the air or in a car
		PCalcT.Air = math.Clamp(PCalcT.Air + 1, 0, 300)
		return
	else
		local vel = ply:GetVelocity()
		local ang = ply:EyeAngles()
		PCalcT.VS = PCalcT.VS * 0.9 + vel:Length() * 0.1
		PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime() * 0.1
		local view = {}
		view.origin = origin
		view.ply = ply
		view.fov = fov
		view.angles = angles
		if PCalcT.Air > 0 then
			PCalcT.Air = PCalcT.Air - (PCalcT.Air/10) --make it end in 10 frames
			view.angles.p = view.angles.p + (PCalcT.Air * 0.25)
			view.angles.r = view.angles.r + PCalcT.Air*0.1
		end
		view.angles.r = angles.r + ang:Right():DotProduct(vel) * 0.01
		view.angles.r = angles.r + math.sin( PCalcT.WT ) * PCalcT.VS * 0.001
		view.angles.p = angles.p + math.sin( PCalcT.WT * 0.5 ) * PCalcT.VS * 0.001
		return view
	end
end
hook.Add("CalcView", "MyCalcView", ShakeView)
