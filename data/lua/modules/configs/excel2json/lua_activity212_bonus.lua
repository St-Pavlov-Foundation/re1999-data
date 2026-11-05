-- chunkname: @modules/configs/excel2json/lua_activity212_bonus.lua

module("modules.configs.excel2json.lua_activity212_bonus", package.seeall)

local lua_activity212_bonus = {}
local fields = {
	id = 2,
	packsId = 4,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity212_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity212_bonus, "configList", _configList)
	rawset(lua_activity212_bonus, "configDict", _configDict)
end

setmetatable(lua_activity212_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity212_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity212_bonus, "configList", nil)
	rawset(lua_activity212_bonus, "configDict", nil)
end

return lua_activity212_bonus
