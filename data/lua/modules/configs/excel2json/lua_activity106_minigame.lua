-- chunkname: @modules/configs/excel2json/lua_activity106_minigame.lua

module("modules.configs.excel2json.lua_activity106_minigame", package.seeall)

local lua_activity106_minigame = {}
local fields = {
	minBlock = 2,
	blockCount = 4,
	victoryRound = 5,
	randomLength = 6,
	id = 1,
	levelTime = 3,
	matPool = 8,
	pointerSpeed = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity106_minigame_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity106_minigame, "configList", _configList)
	rawset(lua_activity106_minigame, "configDict", _configDict)
end

setmetatable(lua_activity106_minigame, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity106_minigame.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity106_minigame, "configList", nil)
	rawset(lua_activity106_minigame, "configDict", nil)
end

return lua_activity106_minigame
