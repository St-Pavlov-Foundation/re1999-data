-- chunkname: @modules/configs/excel2json/lua_monster_group.lua

module("modules.configs.excel2json.lua_monster_group", package.seeall)

local lua_monster_group = {}
local fields = {
	bossId = 8,
	stanceId = 7,
	bgm = 10,
	appearMonsterId = 11,
	sp2Monster = 5,
	appearTimeline = 12,
	sp2Supporter = 6,
	spMonster = 3,
	appearCameraPos = 13,
	aiId = 9,
	spSupporter = 4,
	id = 1,
	monster = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.monster_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_group, "configList", _configList)
	rawset(lua_monster_group, "configDict", _configDict)
end

setmetatable(lua_monster_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_group, "configList", nil)
	rawset(lua_monster_group, "configDict", nil)
end

return lua_monster_group
