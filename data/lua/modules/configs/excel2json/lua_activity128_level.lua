-- chunkname: @modules/configs/excel2json/lua_activity128_level.lua

module("modules.configs.excel2json.lua_activity128_level", package.seeall)

local lua_activity128_level = {}
local fields = {
	season = 1,
	spLevelBg = 5,
	bonus = 6,
	levelBg = 4,
	needExp = 3,
	playerLevel = 2
}
local primaryKey = {
	"season",
	"playerLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity128_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_level, "configList", _configList)
	rawset(lua_activity128_level, "configDict", _configDict)
end

setmetatable(lua_activity128_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_level, "configList", nil)
	rawset(lua_activity128_level, "configDict", nil)
end

return lua_activity128_level
