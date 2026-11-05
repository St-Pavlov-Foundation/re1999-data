-- chunkname: @modules/configs/excel2json/lua_assassin_quest.lua

module("modules.configs.excel2json.lua_assassin_quest", package.seeall)

local lua_assassin_quest = {}
local fields = {
	param = 8,
	display = 10,
	unlock = 9,
	type = 7,
	picture = 4,
	title = 2,
	rewardCount = 11,
	desc = 3,
	mapId = 5,
	id = 1,
	position = 6,
	recommend = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.assassin_quest_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_quest, "configList", _configList)
	rawset(lua_assassin_quest, "configDict", _configDict)
end

setmetatable(lua_assassin_quest, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_quest.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_quest, "configList", nil)
	rawset(lua_assassin_quest, "configDict", nil)
end

return lua_assassin_quest
