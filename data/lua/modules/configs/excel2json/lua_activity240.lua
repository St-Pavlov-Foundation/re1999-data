-- chunkname: @modules/configs/excel2json/lua_activity240.lua

module("modules.configs.excel2json.lua_activity240", package.seeall)

local lua_activity240 = {}
local fields = {
	id = 2,
	isnotPush = 4,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity240_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity240, "configList", _configList)
	rawset(lua_activity240, "configDict", _configDict)
end

setmetatable(lua_activity240, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity240.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity240, "configList", nil)
	rawset(lua_activity240, "configDict", nil)
end

return lua_activity240
