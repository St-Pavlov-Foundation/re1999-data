-- chunkname: @modules/configs/excel2json/lua_activity166_base_level.lua

module("modules.configs.excel2json.lua_activity166_base_level", package.seeall)

local lua_activity166_base_level = {}
local fields = {
	baseId = 2,
	firstBonus = 4,
	activityId = 1,
	level = 3
}
local primaryKey = {
	"activityId",
	"baseId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity166_base_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_base_level, "configList", _configList)
	rawset(lua_activity166_base_level, "configDict", _configDict)
end

setmetatable(lua_activity166_base_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_base_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_base_level, "configList", nil)
	rawset(lua_activity166_base_level, "configDict", nil)
end

return lua_activity166_base_level
