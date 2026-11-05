-- chunkname: @modules/configs/excel2json/lua_activity115_bonus.lua

module("modules.configs.excel2json.lua_activity115_bonus", package.seeall)

local lua_activity115_bonus = {}
local fields = {
	bonus = 4,
	important = 5,
	id = 2,
	activityId = 1,
	needScore = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity115_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity115_bonus, "configList", _configList)
	rawset(lua_activity115_bonus, "configDict", _configDict)
end

setmetatable(lua_activity115_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity115_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity115_bonus, "configList", nil)
	rawset(lua_activity115_bonus, "configDict", nil)
end

return lua_activity115_bonus
