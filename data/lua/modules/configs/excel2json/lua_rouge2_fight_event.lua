-- chunkname: @modules/configs/excel2json/lua_rouge2_fight_event.lua

module("modules.configs.excel2json.lua_rouge2_fight_event", package.seeall)

local lua_rouge2_fight_event = {}
local fields = {
	interactive = 3,
	failInteractive = 5,
	title = 2,
	fightDesc = 8,
	eliteFightDesc = 9,
	dieTwice = 4,
	achievement = 10,
	episodeId = 1,
	fightTaskId = 11,
	monsterMask = 7,
	isChangeScene = 6
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	eliteFightDesc = 2,
	fightDesc = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_fight_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_fight_event, "configList", _configList)
	rawset(lua_rouge2_fight_event, "configDict", _configDict)
end

setmetatable(lua_rouge2_fight_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_fight_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_fight_event, "configList", nil)
	rawset(lua_rouge2_fight_event, "configDict", nil)
end

return lua_rouge2_fight_event
