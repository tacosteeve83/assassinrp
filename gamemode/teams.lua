Teams = { }

function AddTeam( id, name, color, weaponloadout, model, flag, health, armor )
	local NewTeam = { }
	NewTeam.ID = id
	NewTeam.Name = name
	NewTeam.Color = color
	NewTeam.WeaponLoadout = weaponloadout
	NewTeam.Model = model
	NewTeam.Flag = flag
	NewTeam.Health = health
	NewTeam.Armor = armor
	
	table.insert( Teams, NewTeam )
end

 AddTeam( 1, "Citizen", Color( 0, 183, 21, 255 ), {  }, "", "c", nil, nil )
 AddTeam( 2, "Citizen Workers Union", Color( 0, 183, 21, 255 ), {  }, "", "cwu", nil, nil )
 AddTeam( 5, "Combine Civil Authority", Color( 10, 26, 255, 255 ), { "9mm", "rp_stunstick", "rp_zipties", "rp_patdown", "rp_batteringram" }, "models/police.mdl", "cca", 100, 100 )
 AddTeam( 7, "Combine Civil Authority - Commander", Color( 0, 0, 255, 255 ), { "rp_stunstick", "9mm", "mp7", "rp_zipties", "rp_patdown", "rp_batteringram" }, "models/leet_police2.mdl", "cmd", 100, 150 )
AddTeam( 10, "City Administrator", Color( 255, 30, 30, 255 ), { "9mm" }, "models/breen.mdl", "ca", nil, nil )
AddTeam( 11, "Resistance - Member", Color( 0, 255, 0, 255 ), {  }, "", "r", 100, 50 )
AddTeam( 12, "Resistance - Leader", Color( 100, 255, 100, 255 ), { "9mm", "lockpick" }, "", "rl", 100, 100 )