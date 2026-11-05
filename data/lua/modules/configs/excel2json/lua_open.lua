-- chunkname: @modules/configs/excel2json/lua_open.lua

module("modules.configs.excel2json.lua_open", package.seeall)

local lua_open = {}
local fields = {
	isOnline = 3,
	name = 2,
	verifingHide = 11,
	verifingEpisodeId = 7,
	roomLevel = 13,
	playerLv = 4,
	dailyOpenTime = 14,
	episodeId = 5,
	elementId = 6,
	isAlwaysShowBtn = 8,
	bindActivityId = 12,
	id = 1,
	showInEpisode = 9,
	dec = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.open_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_open, "configList", _configList)
	rawset(lua_open, "configDict", _configDict)
end

setmetatable(lua_open, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_open.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_open, "configList", nil)
	rawset(lua_open, "configDict", nil)
end

return lua_open
