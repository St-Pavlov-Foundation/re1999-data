-- chunkname: @modules/configs/excel2json/lua_player_level.lua

module("modules.configs.excel2json.lua_player_level", package.seeall)

local lua_player_level = {}
local fields = {
	addUpRecoverPower = 4,
	addBuyRecoverPower = 5,
	bonus = 6,
	exp = 2,
	maxAutoRecoverPower = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.player_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_player_level, "configList", _configList)
	rawset(lua_player_level, "configDict", _configDict)
end

setmetatable(lua_player_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_player_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_player_level, "configList", nil)
	rawset(lua_player_level, "configDict", nil)
end

return lua_player_level
