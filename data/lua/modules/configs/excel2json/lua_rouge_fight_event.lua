-- chunkname: @modules/configs/excel2json/lua_rouge_fight_event.lua

module("modules.configs.excel2json.lua_rouge_fight_event", package.seeall)

local lua_rouge_fight_event = {}
local fields = {
	interactive = 7,
	title = 2,
	versionInteractive = 9,
	type = 3,
	versionEvent = 10,
	advanceInteractive = 8,
	bossMask = 13,
	episodeId = 4,
	versionEpisode = 5,
	monsterMask = 12,
	id = 1,
	isChangeScene = 11,
	bossDesc = 14,
	episodeIdInstead = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	bossDesc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_fight_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_fight_event, "configList", _configList)
	rawset(lua_rouge_fight_event, "configDict", _configDict)
end

setmetatable(lua_rouge_fight_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_fight_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_fight_event, "configList", nil)
	rawset(lua_rouge_fight_event, "configDict", nil)
end

return lua_rouge_fight_event
