-- chunkname: @modules/configs/excel2json/lua_activity208_bonus.lua

module("modules.configs.excel2json.lua_activity208_bonus", package.seeall)

local lua_activity208_bonus = {}
local fields = {
	id = 2,
	isAllBonus = 3,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity208_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity208_bonus, "configList", _configList)
	rawset(lua_activity208_bonus, "configDict", _configDict)
end

setmetatable(lua_activity208_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity208_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity208_bonus, "configList", nil)
	rawset(lua_activity208_bonus, "configDict", nil)
end

return lua_activity208_bonus
