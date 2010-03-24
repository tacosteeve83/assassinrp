function IncludeResFolder( dir )

	local files = file.FindInLua( "Kiwi/content/" .. dir .. "*" )

	for k, v in pairs( files ) do
		if( string.find( v, ".vmt" ) or string.find( v, ".vtf" ) or string.find( v, ".wav" ) or string.find( v, ".mdl" ) or string.find( v, ".dx90.vtx" ) or string.find( v, ".dx80.vtx" ) or string.find( v, ".phy" ) or string.find( v, ".sw.vtx" ) or string.find( v, ".vvd" ) ) then
			resource.AddFile( dir .. v )
		end
	end
end

function GetPlayer( name )
	local ply = nil
	
	for k, v in pairs( player.GetAll() ) do
		if ( string.find( v:Nick(), name ) != nil ) then
			ply = v
		end
		
		if ( string.find( v:Name(), name ) != nil ) then
			ply = v
		end
	end
	
	return ply
end

function ReferenceFix( data )
	if( type( data ) == "table" ) then
		return table.Copy( data )
	else
		return data
	end
end

function NilFix( value, default )
	if ( value == nil ) then
		return default
	else
		return value
	end
end

function TalkToRange(msg, pos, size)
	local ents = ents.FindInSphere(pos, size)

	for k, v in pairs(ents) do
		if v:IsPlayer() then
			v:ChatPrint(msg)
			v:PrintMessage(2, msg)
		end
	end
end


function Notify(ply, msgtype, len, msg)
	umsg.Start("_Notify", ply)
		umsg.String(msg)
		umsg.Short(msgtype)
		umsg.Long(len)
	umsg.End()
end

function NotifyAll(msgtype, len, msg)
	for k, v in pairs(player.GetAll()) do
		Notify(v, msgtype, len, msg)
	end
end

function PrintMessageAll(msgtype, msg)
	for k, v in pairs(player.GetAll()) do
		v:PrintMessage(msgtype, msg)
	end
end
