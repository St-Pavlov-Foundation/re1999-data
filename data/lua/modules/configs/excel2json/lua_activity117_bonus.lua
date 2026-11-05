-- chunkname: @modules/configs/excel2json/lua_activity117_bonus.lua

module("modules.configs.excel2json.lua_activity117_bonus", package.seeall)

local lua_activity117_bonus = {}
local fields = {
	needScore = 4,
	bonus = 5,
	id = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity117_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity117_bonus, "configList", _configList)
	rawset(lua_activity117_bonus, "configDict", _configDict)
end

setmetatable(lua_activity117_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity117_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity117_bonus, "configList", nil)
	rawset(lua_activity117_bonus, "configDict", nil)
end

return lua_activity117_bonus
