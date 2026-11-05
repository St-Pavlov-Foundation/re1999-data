-- chunkname: @modules/configs/excel2json/lua_activity143_bonus.lua

module("modules.configs.excel2json.lua_activity143_bonus", package.seeall)

local lua_activity143_bonus = {}
local fields = {
	bonus = 3,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity143_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity143_bonus, "configList", _configList)
	rawset(lua_activity143_bonus, "configDict", _configDict)
end

setmetatable(lua_activity143_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity143_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity143_bonus, "configList", nil)
	rawset(lua_activity143_bonus, "configDict", nil)
end

return lua_activity143_bonus
