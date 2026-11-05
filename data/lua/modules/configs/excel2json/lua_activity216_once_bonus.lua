-- chunkname: @modules/configs/excel2json/lua_activity216_once_bonus.lua

module("modules.configs.excel2json.lua_activity216_once_bonus", package.seeall)

local lua_activity216_once_bonus = {}
local fields = {
	bonus = 3,
	activityId = 1,
	needFinishTaskNum = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity216_once_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity216_once_bonus, "configList", _configList)
	rawset(lua_activity216_once_bonus, "configDict", _configDict)
end

setmetatable(lua_activity216_once_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity216_once_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity216_once_bonus, "configList", nil)
	rawset(lua_activity216_once_bonus, "configDict", nil)
end

return lua_activity216_once_bonus
