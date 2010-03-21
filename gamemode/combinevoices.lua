CombineSounds = { }

function GetVal( val, default )
	if( val == nil ) then
		return default
	else
		return val
	end
end

function AddCombineSound( id, path, text )
	local sound = { }
	sound.path = path
	sound.line = GetVal( text, "" )
	--table.insert( CombineSounds, Sound )
	CombineSounds[id] = sound
	
end

function ccPlayCombineSound( ply, cmd, args )
	local id = args[1]
	if not ply:IsCombine() then
		ply:PrintChat( "Need to be combine", false )
		return
	end
	if( CombineSounds[id] == nil ) then 
		ply:PrintChat( "Invalid ID", false )
		return
	end
	local sound = CombineSounds[id]	
	local path = sound.path
	local num = math.random( 1, 2 )
	ply:EmitSound( Sound( "npc/metropolice/vo/on" .. num .. ".wav", 55, 100 ) )
		local num = math.random( 1, 4 )
		ply:EmitSound( Sound( "npc/metropolice/vo/off" .. num .. ".wav", 55, 100) )
	timer.Simple( 1, EmitSound )
	ply:ConCommand( "say " .. sound.line )
end
concommand.Add( "rp_emit", ccPlayCombineSound )

function ccListVoice( ply, cmd, args ) 
	ply:PrintChat( "List of Civil Protection Voices", false )
	ply:PrintChat( "Use rp_emit <id> to play", false )
	for _, voice in pairs( CombineSounds ) do
	ply:PrintChat( _ .. " - " .. voice.line .. " - " .. voice.path .. "", false )
	end
end
concommand.Add( "rp_soundlist", ccListVoice )

AddCombineSound( "1199", "npc/metropolice/vo/11-99officerneedsassistance.wav", "/r 11-99, officer needs assistance! say 11-99, officer needs assistance!" )	
AddCombineSound( "administer", "npc/metropolice/vo/administer.wav","Administer.")
AddCombineSound( "affirmative", "npc/metropolice/vo/affirmative.wav", "/r Affirmative.")
AddCombineSound( "youcango", "npc/metropolice/vo/allrightyoucango.wav", "All right, you can go.")
AddCombineSound( "movein", "npc/metropolice/vo/allunitsmovein.wav", "/r All units, move in.")
AddCombineSound( "amputate", "npc/metropolice/vo/amputate.wav",  "Amputate.")
AddCombineSound( "anticitizen", "npc/metropolice/vo/anticitizen.wav",  "Anticitizen.")
AddCombineSound( "apply", "npc/metropolice/vo/apply.wav", "Apply.")
AddCombineSound( "cauterize", "npc/metropolice/vo/cauterize.wav", "Cauterize.")
AddCombineSound( "miscount", "npc/metropolice/vo/checkformiscount.wav", "/r Check for miscount.")
AddCombineSound( "chuckle", "npc/metropolice/vo/chuckle.wav", "/me chuckles")
AddCombineSound( "citizen", "npc/metropolice/vo/citizen.wav", "Citizen.")
AddCombineSound( "control100percent", "npc/metropolice/vo/control100percent.wav", "/r Control is 100 percent at this location. No sign of that 647-E.")
AddCombineSound( "controlsection", "npc/metropolice/vo/controlsection.wav", "Control section.")
AddCombineSound( "converging", "npc/metropolice/vo/converging.wav", "Converging.")
AddCombineSound( "copy", "npc/metropolice/vo/copy.wav", "/r Copy.")
AddCombineSound( "coverme", "npc/metropolice/vo/covermegoingin.wav", "Cover me, I'm going in!")
AddCombineSound( "trespass", "npc/metropolice/vo/criminaltrespass63.wav", "/r 6-3 Criminal Trespass.")
AddCombineSound( "destroythatcover", "npc/metropolice/vo/destroythatcover.wav", "Destroy that cover!")
AddCombineSound( "introuble", "npc/metropolice/vo/dispatchineed10-78.wav", "/r Dispatch, I need 10-78. Officer in trouble!")
AddCombineSound( "document", "npc/metropolice/vo/document.wav", "Document.")
AddCombineSound( "dontmove", "npc/metropolice/vo/dontmove.wav", "Don't move!")
AddCombineSound( "verdictadministered", "npc/metropolice/vo/finalverdictadministered.wav", "/r Final verdict administered.")
AddCombineSound( "finalwarning", "npc/metropolice/vo/finalwarning.wav", "Final warning.")
AddCombineSound( "firstwarningmove", "npc/metropolice/vo/firstwarningmove.wav", "First warning. Move away.")
AddCombineSound( "getdown", "npc/metropolice/vo/getdown.wav", "/y Get down!")
AddCombineSound( "getoutofhere", "npc/metropolice/vo/getoutofhere.wav", "Get out of here.")
AddCombineSound( "grenade", "npc/metropolice/vo/grenade.wav", "/y Grenade!")
AddCombineSound( "help", "npc/metropolice/vo/help.wav", "/y Help!")
AddCombineSound( "hesrunning", "npc/metropolice/vo/hesrunning.wav", "/r He's running!")
AddCombineSound( "holdit", "npc/metropolice/vo/holdit.wav", "/y Hold it!")
AddCombineSound( "investigate", "npc/metropolice/vo/investigate.wav", "/r Investigate.")
AddCombineSound( "investigating", "npc/metropolice/vo/investigating10-103.wav", "/r Investigating 10-103.")
AddCombineSound( "movealong", "npc/metropolice/vo/isaidmovealong.wav", "I said move along.")
AddCombineSound( "isolate", "npc/metropolice/vo/isolate.wav","Isolate.")
AddCombineSound( "keepmoving", "npc/metropolice/vo/keepmoving.wav", "Keep moving.")
AddCombineSound( "location", "npc/metropolice/vo/location.wav", "/r Location.")
AddCombineSound( "nowgetoutofhere", "npc/metropolice/vo/nowgetoutofhere.wav", "Now get out of here.")
AddCombineSound( "officerneedshelp", "npc/metropolice/vo/officerneedshelp.wav", "/r Officer needs help!")
AddCombineSound( "prosecute", "npc/metropolice/vo/prosecute.wav", "Prosecute.")
AddCombineSound( "residentialblock", "npc/metropolice/vo/residentialblock.wav", "/r Residential block.")
AddCombineSound( "rogerthat", "npc/metropolice/vo/rodgerthat.wav", "/r Roger that.")
AddCombineSound( "searchingforsuspect", "npc/metropolice/vo/searchingforsuspect.wav", "/r Searching for suspect, no status.")
AddCombineSound( "shit", "npc/metropolice/vo/shit.wav", "/y Shit!")
AddCombineSound( "sweepingforsuspect", "npc/metropolice/vo/sweepingforsuspect.wav", "/r Sweeping for suspect.")
AddCombineSound( "thereheis", "npc/metropolice/vo/thereheis.wav", "/y There he is!")
AddCombineSound( "unlawfulentry", "npc/metropolice/vo/unlawfulentry603.wav", "/r 603, unlawful entry.")
AddCombineSound( "vacatecitizen", "npc/metropolice/vo/vacatecitizen.wav", "Vacate, citizen.")
AddCombineSound( "malcompliance", "npc/metropolice/vo/youwantamalcomplianceverdict.wav", "You want a malcompliance verdict?")
AddCombineSound( "uknockedit", "npc/metropolice/vo/youknockeditover.wav", "You knocked it over, pick it up." )
AddCombineSound( "backup", "vo/trainyard/ba_backup.wav", "Back up." )
AddCombineSound( "goon", "vo/trainyard/ba_goon.wav", "Go on..." )
AddCombineSound( "getinhere", "vo/trainyard/ba_inhere01.wav", "Get in here." )
AddCombineSound( "isaidmove", "vo/trainyard/ba_move01.wav", "/y I SAID MOVE!" )
AddCombineSound( "noimgood", "vo/trainyard/ba_noimgood.wav", "No, I'm good." )
AddCombineSound( "pickupcan", "npc/metropolice/vo/pickupthecan1.wav", "Pick up that can." )
AddCombineSound( "pickupcan2", "npc/metropolice/vo/pickupthecan3.wav", "I said, pick up the can." )
AddCombineSound( "putintrash", "npc/metropolice/vo/putitinthetrash.wav", "Now, put it in the trashcan." )
AddCombineSound( "needanyhelp", "npc/metropolice/vo/needanyhelpwiththisone.wav", "Need any help with this one?" )

HumanSounds = { }

function AddHumanSounds( id, path, text, female )
	local sound = { }
	sound.path = path
	sound.line = GetVal( text, "" )
	sound.female = GetVal( female, "")
	HumanSounds[id] = sound
end

function ccPlayHumanSound( ply, cmd, args )
	local id = args[1]
	if( ply:IsCombine() ) then 
		ply:PrintChat( "You need to be citizen", false )
		return
	end
	if( HumanSounds[id] == nil ) then 
		ply:PrintChat( "Invalid ID", false )
		return
	end
	local sound = HumanSounds[id]
	local path = sound.path
	util.PrecacheSound( path )
	ply:EmitSound( path, 65, 100 )
	ply:ConCommand( "say " .. sound.line )
end
concommand.Add( "rp_playsound", ccPlayHumanSound )

function ccListVoice( ply, cmd, args ) 
	ply:PrintChat( "List of Human Voices", false )
	ply:PrintChat( "use rp_playsound <id> to play", false )
	for _, voice in pairs( HumanSounds ) do
		ply:PrintChat( _ .. " - " .. voice.line .. " - " .. voice.path .. "", false )
	end
end
concommand.Add( "rp_listvoices", ccListVoice )

AddHumanSounds( "dontthink", "vo/npc/male01/question01.wav", "I don't think this war is ever gonna end.", "vo/npc/female01/question01.wav" )
AddHumanSounds( "sellinsurance", "vo/npc/male01/question02.wav", "To think! All I wanted to do was sell insurance.", "vo/npc/female01/question02.wav" )
AddHumanSounds( "dontdream", "vo/npc/male01/question03.wav", "I don't dream anymore.", "vo/npc/female01/question03.wav" )
AddHumanSounds( "whoamikid", "vo/npc/male01/question04.wav", "When this is all over I'm... nah, who am I kidding.", "vo/npc/female01/question04.wav" )
AddHumanSounds( "dejavu", "vo/npc/male01/question05.wav", "Woah. Dejavu.", "vo/npc/female01/question05.wav" )
AddHumanSounds( "dreamcheese", "vo/npc/male01/question06.wav", "Sometimes.. I dream about cheese.", "vo/npc/female01/question06.wav" )
AddHumanSounds( "smellthat", "vo/npc/male01/question07.wav", "You smell that? It's freedom.", "vo/npc/female01/question07.wav" )
AddHumanSounds( "doctorbreen", "vo/npc/male01/question08.wav", "If I ever get my hands on Doctor Breen..", "vo/npc/female01/question08.wav" )
AddHumanSounds( "eatahorse", "vo/npc/male01/question09.wav", "I could eat a horse! Hooves and all..", "vo/npc/female01/question09.wav" )
AddHumanSounds( "cantbelieve", "vo/npc/male01/question10.wav", "I can't believe this day has finally come!", "vo/npc/female01/question10.wav" )
AddHumanSounds( "partofplan", "vo/npc/male01/question11.wav", "I'm pretty sure this isn't part of the plan.", "vo/npc/female01/question11.wav" )
AddHumanSounds( "gettingworse", "vo/npc/male01/question12.wav", "Looks to me like things are getting worse, not better.", "vo/npc/female01/question12.wav" )
AddHumanSounds( "ificouldlive", "vo/npc/male01/question13.wav", "If I could live my life over again..", "vo/npc/female01/question13.wav" )
AddHumanSounds( "remindsme", "vo/npc/male01/question14.wav", "I'm not even gonna tell you what that reminds me of.", "vo/npc/female01/question14.wav" )
AddHumanSounds( "stalkeroutofme", "vo/npc/male01/question15.wav", "They're never gonna make a stalker out of me!", "vo/npc/female01/question15.wav" )
AddHumanSounds( "changeintheair", "vo/npc/male01/question16.wav", "Finally! Change is in the air!", "vo/npc/female01/question16.wav" )
AddHumanSounds( "feelit", "vo/npc/male01/question17.wav", "You feel it? I feel it.", "vo/npc/female01/question17.wav" )
AddHumanSounds( "dontfeelanything", "vo/npc/male01/question18.wav", "I don't feel anything anymore.", "vo/npc/female01/question18.wav" )
AddHumanSounds( "shower", "vo/npc/male01/question19.wav", "I can't remember the last time I had a shower.", "vo/npc/female01/question19.wav" )
AddHumanSounds( "badmemory", "vo/npc/male01/question20.wav", "Some day.. this'll all be a bad memory.", "vo/npc/female01/question20.wav" )
AddHumanSounds( "bettingman", "vo/npc/male01/question21.wav", "I'm not a betting man, but the odds are not good.", "vo/npc/female01/question21.wav" )
AddHumanSounds( "anyonecare", "vo/npc/male01/question22.wav", "Doesn't anyone care what I think?", "vo/npc/female01/question22.wav" )
AddHumanSounds( "tune", "vo/npc/male01/question23.wav", "I can't get this tune out of my head! *whistles*", "vo/npc/female01/question23.wav" )
AddHumanSounds( "oneofthosedays", "vo/npc/male01/question25.wav", "I just knew it was gonna be one of those days.", "vo/npc/female01/question25.wav" )
AddHumanSounds( "bullshit", "vo/npc/male01/question26.wav", "This is bullshit!", "vo/npc/female01/question26.wav" )
AddHumanSounds( "atesomethingbad", "vo/npc/male01/question27.wav", "I think I ate something bad..", "vo/npc/female01/question27.wav" )
AddHumanSounds( "hungry", "vo/npc/male01/question28.wav", "God I'm hungry!", "vo/npc/female01/question28.wav" )
AddHumanSounds( "imgonnamate", "vo/npc/male01/question29.wav", "When this is all over, I'm gonna mate.", "vo/npc/female01/question29.wav" )
AddHumanSounds( "nokidsaround", "vo/npc/male01/question30.wav", "I'm glad there's no kids around to see this.", "vo/npc/female01/question30.wav" )

AddHumanSounds( "alloveryou", "vo/npc/male01/answer01.wav", "That's you all over.", "vo/npc/female01/answer01.wav" )
AddHumanSounds( "againstyou", "vo/npc/male01/answer02.wav", "I won't hold it against you.", "vo/npc/female01/answer02.wav" )
AddHumanSounds( "figures", "vo/npc/male01/answer03.wav", "Figures.", "vo/npc/female01/answer03.wav" )
AddHumanSounds( "dwell", "vo/npc/male01/answer04.wav", "Try not to dwell on it.", "vo/npc/female01/answer04.wav" )
AddHumanSounds( "talklater", "vo/npc/male01/answer05.wav", "Can we talk about this later?", "vo/npc/female01/answer05.wav" )
AddHumanSounds( "samehere", "vo/npc/male01/answer07.wav", "Same here.", "vo/npc/female01/answer07.wav" )
AddHumanSounds( "iknowhatumean", "vo/npc/male01/answer08.wav", "I know what you mean.", "vo/npc/female01/answer08.wav" )
AddHumanSounds( "talking2self", "vo/npc/male01/answer09.wav", "You're talking to yourself again.", "vo/npc/female01/answer09.wav" )
AddHumanSounds( "tooloud", "vo/npc/male01/answer10.wav", "I wouldn't say that too loud.", "vo/npc/female01/answer10.wav" )
AddHumanSounds( "tombstone", "vo/npc/male01/answer11.wav", "I'll put it on your tombstone!", "vo/npc/female01/answer11.wav" )
AddHumanSounds( "thinking", "vo/npc/male01/answer12.wav", "It doesn't bear thinking about.", "vo/npc/female01/answer12.wav" )
AddHumanSounds( "withyou", "vo/npc/male01/answer13.wav", "I'm with you.", "vo/npc/female01/answer13.wav" )
AddHumanSounds( "youmeboth", "vo/npc/male01/answer14.wav", "Heh! You and me both.", "vo/npc/female01/answer14.wav" )
AddHumanSounds( "lookingatit", "vo/npc/male01/answer15.wav", "Thaaa.. one way of looking at it.", "vo/npc/female01/answer15.wav" )
AddHumanSounds( "originalthouht", "vo/npc/male01/answer16.wav", "Have you ever had an original thought?", "vo/npc/female01/answer16.wav" )
AddHumanSounds( "shutup", "vo/npc/male01/answer17.wav", "I'm not even gonna tell you to shut up.", "vo/npc/female01/answer17.wav" )
AddHumanSounds( "concentrate", "vo/npc/male01/answer18.wav", "Let's concentrate on the task at hand!", "vo/npc/female01/answer18.wav" )
AddHumanSounds( "mindwork", "vo/npc/male01/answer19.wav", "Keep your mind on your work!", "vo/npc/female01/answer19.wav" )
AddHumanSounds( "gutter", "vo/npc/male01/answer20.wav", "Your mind is in the gutter.", "vo/npc/female01/answer20.wav" )
AddHumanSounds( "sosure", "vo/npc/male01/answer21.wav", "Don't be so sure of that.", "vo/npc/female01/answer21.wav" )
AddHumanSounds( "youneverknow", "vo/npc/male01/answer22.wav", "You never know.", "vo/npc/female01/answer22.wav" )
AddHumanSounds( "nevertell", "vo/npc/male01/answer23.wav", "You never can tell.", "vo/npc/female01/answer23.wav" )
AddHumanSounds( "tellingme", "vo/npc/male01/answer24.wav", "Why are you telling ME?", "vo/npc/female01/answer24.wav" )
AddHumanSounds( "howaboutthat", "vo/npc/male01/answer25.wav", "How about that?", "vo/npc/female01/answer25.wav" )
AddHumanSounds( "informationrequire", "vo/npc/male01/answer26.wav", "That's more information than I require.", "vo/npc/female01/answer26.wav" )
AddHumanSounds( "wannabet", "vo/npc/male01/answer27.wav", "Heheh, wanna bet?", "vo/npc/female01/answer27.wav" )
AddHumanSounds( "dime", "vo/npc/male01/answer28.wav", "I wish I had a dime for every time somebody said that.", "vo/npc/female01/answer28.wav" )
AddHumanSounds( "doaboutit", "vo/npc/male01/answer29.wav", "What am I supposed to do about it?", "vo/npc/female01/answer29.wav" )
AddHumanSounds( "talkingtome", "vo/npc/male01/answer30.wav", "You talkin to me?", "vo/npc/female01/answer30.wav" )
AddHumanSounds( "talkbutt", "vo/npc/male01/answer31.wav", "You should nip that kind of talk in the butt.", "vo/npc/female01/answer31.wav" )
AddHumanSounds( "righton", "vo/npc/male01/answer32.wav", "Right on!", "vo/npc/female01/answer32.wav" )
AddHumanSounds( "argument", "vo/npc/male01/answer33.wav", "No argument there.", "vo/npc/female01/answer33.wav" )
AddHumanSounds( "hawaii", "vo/npc/male01/answer34.wav", "Don't forget Hawaii!", "vo/npc/female01/answer34.wav" )
AddHumanSounds( "trynot", "vo/npc/male01/answer35.wav", "Try not to let it get to you.", "vo/npc/female01/answer35.wav ")
AddHumanSounds( "firsttime", "vo/npc/male01/answer36.wav", "Wouldn't be the first time.", "vo/npc/female01/answer36.wav" )
AddHumanSounds( "sureaboutthat", "vo/npc/male01/answer37.wav", "You sure about that?", "vo/npc/female01/answer37.wav" )
AddHumanSounds( "leavealone", "vo/npc/male01/answer38.wav", "Leave it alone.", "vo/npc/female01/answer38.wav" )
AddHumanSounds( "enough", "vo/npc/male01/answer39.wav", "That's enough out of you.", "vo/npc/female01/answer39.wav" )
AddHumanSounds( "firsttimeeverything", "vo/npc/male01/answer40.wav", "There's a first time for everything.", "vo/npc/female01/answer40.wav" )

AddHumanSounds( "combine", "vo/npc/male01/combine01.wav", "/y Combine!", "vo/npc/female01/combine01.wav" )
AddHumanSounds( "doingsomething", "vo/npc/male01/doingsomething.wav", "Shouldn't we.. uhh.. be doing something?", "vo/npc/female01/doingsomething.wav" )
AddHumanSounds( "excuseme", "vo/npc/male01/excuseme01.wav", "Excuse me.", "vo/npc/female01/excuseme01.wav" )
AddHumanSounds( "fantastic", "vo/npc/male01/fantastic01.wav", "Fantastic!", "vo/npc/female01/fantastic.wav" )
AddHumanSounds( "finally", "vo/npc/male01/finally.wav", "Finally.", "vo/npc/female01/finally.wav" )
AddHumanSounds( "gethellout", "vo/npc/male01/gethellout.wav", "/y Get the hell out of here!", "vo/npc/female01/gethellout.wav" )
AddHumanSounds( "goodgod", "vo/npc/male01/goodgod.wav", "Good god!", "vo/npc/female01/goodgod.wav" )
AddHumanSounds( "gotone1", "vo/npc/male01/gotone01.wav", "Got one!", "vo/npc/female01/gotone01.wav" )
AddHumanSounds( "gotone2", "vo/npc/male01/gotone02.wav", "Hahah! I got one!", "vo/npc/female01/.wav" )
AddHumanSounds( "help", "vo/npc/male01/help01.wav", "/y HELP!", "vo/npc/female01/help01.wav" )
AddHumanSounds( "hi", "vo/npc/male01/hi01.wav", "Hi.", "vo/npc/female01/hi01.wav" )
AddHumanSounds( "illstayhere", "vo/npc/male01/illstayhere01.wav", "I'll stay here.", "vo/npc/female01/illstayhere01.wav" )
AddHumanSounds( "leadtheway", "vo/npc/male01/leadtheway01.wav", "You lead the way!", "vo/npc/female01/leadtheway01.wav" )
AddHumanSounds( "letsgo", "vo/npc/male01/letsgo01.wav", "/y Let's go!", "vo/npc/female01/letsgo01.wav" )
AddHumanSounds( "noscream1", "vo/npc/male01/no01.wav", "No! NO!", "vo/npc/female01/no01.wav" )
AddHumanSounds( "noscream2", "vo/npc/male01/no02.wav", "/y Noooooo!", "vo/npc/female01/no02.wav" )
AddHumanSounds( "imready", "vo/npc/male01/okimready01.wav", "Ok, I'm ready.", "vo/npc/female01/okimready01.wav" )
AddHumanSounds( "oneforme", "vo/npc/male01/oneforme.wav", "One for me and one... for me.", "vo/npc/female01/oneforme.wav" )
AddHumanSounds( "overhere", "vo/npc/male01/overhere01.wav", "/y Hey, over here!", "vo/npc/female01/overhere01.wav" )
AddHumanSounds( "runforyourlife", "vo/npc/male01/runforyourlife01.wav", "/y Run for your life!", "vo/npc/female01/runforyourlife.wav" )
AddHumanSounds( "sorry", "vo/npc/male01/sorry01.wav", "Sorry.", "vo/npc/female01/sorry01.wav" )
AddHumanSounds( "heregoesnothing", "vo/npc/male01/squad_affirm06.wav", "Here goes nothing.", "vo/npc/female01/squad_affirm06.wav" )
AddHumanSounds( "run", "vo/npc/male01/strider_run.wav", "/y Ruuuuun!", "vo/npc/female01/strider_run.wav" )
AddHumanSounds( "donicely", "vo/npc/male01/thislldonicely01.wav", "This'll do nicely!", "vo/npc/female01/thislldonicely01.wav" )
AddHumanSounds( "waitingsomebody", "vo/npc/male01/waitingsomebody.wav", "You waiting for somebody?", "vo/npc/female01/waitingsomebody.wav" )
AddHumanSounds( "whoops", "vo/npc/male01/whoops01.wav", "Whoops.", "vo/npc/female01/whoops01.wav" )
AddHumanSounds( "yeah", "vo/npc/male01/yeah02.wav", "Yeah!", "vo/npc/female01/yeah02.wav" )
AddHumanSounds( "yougotit", "vo/npc/male01/yougotit02.wav", "You got it!", "vo/npc/female01/yougotit.wav" )

OverwatchSounds = { }

function AddOverwatchSounds( id, path, text )
	local sound = { }
	sound.path = path
	sound.line = GetVal( text, "" )
	OverwatchSounds[id] = sound
end

function ccPlayOverwatchSound( ply, cmd, args )
	local id = args[1]
	if( ply:Team() == 8 or ply:Team() == 9 ) then 
		ply:PrintChat( "Need to be Overwatch", false )
		return
	end	
	if( OverwatchSounds[id] == nil ) then 
		ply:PrintChat( "Invalid ID", false )
		return
	end
	local sound = OverwatchSounds[id]
	local path = sound.path
	local num = math.random( 1, 2 )
	ply:EmitSound( Sound( "npc/combine_soldier/vo/on" .. num .. ".wav", 35, 100 ) )
	local num = math.random( 1, 3 )
		ply:EmitSound( Sound( "npc/combine_soldier/vo/off" .. num .. ".wav", 35, 100 ) )
	ply:ConCommand( "say " .. sound.line )
end
concommand.Add( "rp_owemit", ccPlayOverwatchSound )

AddOverwatchSounds( "hvtcontained", "npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav", "/r Overwatch confirms HVT contained." )
AddOverwatchSounds( "teamisdown", "npc/combine_soldier/vo/overwatchteamisdown.wav", "/r Overwatch team is down, sector not controlled." )
AddOverwatchSounds( "heavyresistance", "npc/combine_soldier/vo/heavyresistance.wav", "/r Overwatch advise, very heavy resistance." )
AddOverwatchSounds( "possiblehostiles", "npc/combine_soldier/vo/overwatchreportspossiblehostiles.wav", "/r Overwatch reports possible hostiles inbound." )
