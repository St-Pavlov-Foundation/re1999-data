-- chunkname: @modules/configs/excel2json/lua_activity191_relation_select.lua

module("modules.configs.excel2json.lua_activity191_relation_select", package.seeall)

local lua_activity191_relation_select = {}
local fields = {
	tag = 2,
	sortIndex = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"tag"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_relation_select_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_relation_select, "configList", _configList)
	rawset(lua_activity191_relation_select, "configDict", _configDict)
end

setmetatable(lua_activity191_relation_select, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_relation_select.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_relation_select, "configList", nil)
	rawset(lua_activity191_relation_select, "configDict", nil)
end

return lua_activity191_relation_select
