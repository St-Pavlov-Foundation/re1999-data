-- chunkname: @modules/configs/excel2json/lua_activity101_sp_bonus.lua

module("modules.configs.excel2json.lua_activity101_sp_bonus", package.seeall)

local lua_activity101_sp_bonus = {}
local fields = {
	canGetSignInDays = 6,
	taskDesc = 3,
	canGetDate = 5,
	id = 2,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	taskDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity101_sp_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity101_sp_bonus, "configList", _configList)
	rawset(lua_activity101_sp_bonus, "configDict", _configDict)
end

setmetatable(lua_activity101_sp_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity101_sp_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity101_sp_bonus, "configList", nil)
	rawset(lua_activity101_sp_bonus, "configDict", nil)
end

return lua_activity101_sp_bonus
