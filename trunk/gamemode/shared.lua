DeriveGamemode( "sandbox" )

GM.Name = "Kiwi"
GM.Author = "-=Assassin=-"

Items = { }

-- Register a item.
function RegisterItem( ItemTable )
	Items[ ItemTable.UniqueID ] = ItemTable
end

-- Include all items.
for k, v in pairs( file.FindInLua( "Kiwi/gamemode/items/*.lua" ) ) do include( "items/" .. v ) end

-- Setup all the teams.
for k, v in pairs( Teams ) do
	team.SetUp( v.ID, v.Name, v.Color )
end

PlayerModels = 
{
	Model( "models/humans/group01/male_01.mdl" ),
    Model( "models/humans/group01/male_02.mdl" ),
    Model( "models/humans/group01/male_03.mdl" ),
	Model( "models/humans/group01/male_04.mdl" ),
	Model( "models/humans/group01/male_06.mdl" ),
	Model( "models/humans/group01/male_07.mdl" ),
    Model( "models/humans/group01/male_08.mdl" ),
    Model( "models/humans/group01/male_09.mdl" ),
    Model( "models/humans/group02/male_01.mdl" ),
    Model( "models/humans/group02/male_02.mdl" ),
    Model( "models/humans/group02/male_03.mdl" ),
    Model( "models/humans/group02/male_04.mdl" ),
    Model( "models/humans/group02/male_06.mdl" ),
    Model( "models/humans/group02/male_07.mdl" ),
    Model( "models/humans/group02/male_08.mdl" ),
    Model( "models/humans/group02/male_09.mdl" ),
	Model( "models/humans/group01/female_01.mdl" ),
    Model( "models/humans/group01/female_02.mdl" ),
    Model( "models/humans/group01/female_03.mdl" ),
	Model( "models/humans/group01/female_04.mdl" ),
    Model( "models/humans/group01/female_06.mdl" ),
    Model( "models/humans/group01/female_07.mdl" ),
    Model( "models/humans/group02/female_01.mdl" ),
    Model( "models/humans/group02/female_02.mdl" ),
    Model( "models/humans/group02/female_03.mdl" ),
	Model( "models/humans/group02/female_04.mdl" ),
    Model( "models/humans/group02/female_06.mdl" ),
    Model( "models/humans/group02/female_07.mdl" )
}

BlockedModels = 
{
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props_canal/canal_bridge03b.mdl",
	"models/props_canal/canal_bridge03a.mdl",
	"models/props_canal/canal_bridge02.mdl",
	"models/props_canal/canal_bridge01.mdl",
	"models/props_phx/mk-82.mdl",
	"models/props_phx/torpedo.mdl",
	"models/props_phx/ww2bomb.mdl",
	"models/props_phx/amraam.mdl",
	"models/props_phx/rocket1.mdl",
	"models/props_combine/Combine_Citadel001.mdl",
	"models/props_junk/gascan001a.mdl",
	"models/props_canal/locks_large.mdl",
	"models/props_canal/locks_large_b.mdl",
	"models/props_phx/misc/flakshell_big.mdl",
	"models/props_phx/oildrum001_explosive.mdl",
	"models/props_phx/misc/potato_launcher_explosive.mdl",
	"models/props_junk/propane_tank001a.mdl",
	"models/props_phx/ball.mdl",
	"models/props_phx/oildrum001.mdl",
	"models/props_phx/facepunch_logo.mdl",
	"models/props_phx/facepunch_barrel.mdl",
	"models/props_phx/cannonball.mdl",
	"models/props_phx/torpedo.mdl",
	"models/props/cs_inferno/bell_large.mdl",
	"models/props/cs_inferno/bell_largeB.mdl",
	"models/props/cs_inferno/bell_small.mdl",
	"models/props/cs_inferno/bell_smallB.mdl",
	"models/props_phx/huge/tower.mdl",
	"models/props_phx/misc/smallcannonball.mdl",
	"models/props_phx/huge/evildisc_corp.mdl",
	"models/props_phx/playfield.mdl",
	"models/props_phx/cannon.mdl",
	"models/props_foliage/oak_tree01.mdl",
	"models/props_foliage/shrub_01a.mdl",
	"models/props_foliage/tree_cliff_01a.mdl",
	"models/props_foliage/tree_cliff_02a.mdl",
	"models/props_foliage/tree_deciduous_01a-lod.mdl",
	"models/props_foliage/tree_deciduous_01a.mdl",
	"models/props_foliage/tree_deciduous_02a.mdl",
	"models/props_foliage/tree_deciduous_03a.mdl",
	"models/props_foliage/tree_deciduous_03b.mdl",
	"models/props_foliage/tree_poplar_01.mdl",
	"models/props/de_nuke/coolingtank.mdl",
	"models/props/de_nuke/storagetank.mdl",
	"models/props_buildings/building_002a.mdl",
	"models/props_buildings/row_corner_1_fullscale.mdl",
	"models/props_buildings/row_church_fullscale.mdl",
	"models/props_buildings/project_destroyedbuildings01.mdl",
	"models/props_buildings/project_building03.mdl",
	"models/props_buildings/project_building02.mdl",
	"models/props_buildings/project_building01.mdl",
	"models/props_buildings/row_res_1_fullscale.mdl",
	"models/props_buildings/row_res_2_ascend_fullscale.mdl",
	"models/props_buildings/watertower_001a.mdl",
	"models/props_buildings/watertower_002a.mdl",
	"models/props_combine/CombineTrain01a.mdl",
	"models/props_combine/combine_train02a.mdl",
	"models/props_combine/combine_train02b.mdl",
	"models/props_trainstation/train004.mdl",
	"models/props_trainstation/train003.mdl",
	"models/props_trainstation/train002.mdl",
	"models/props_trainstation/traincar_bars001.mdl",
	"models/props_trainstation/traincar_bars002.mdl",
	"models/props_trainstation/traincar_bars003.mdl",
	"models/props_trainstation/Traintrack001c.mdl",
	"models/props_trainstation/Traintrack006b.mdl",
	"models/props_trainstation/Traintrack006c.mdl",
	"models/props_italian/anzio_bell.mdl",
	"models/props_c17/gravestone_coffinpiece001a.mdl",
	"models/props_c17/gravestone_coffinpiece002a.mdl"
}
