-- chunkname: @modules/configs/excel2json/lua_activity130_oper_group.lua

module("modules.configs.excel2json.lua_activity130_oper_group", package.seeall)

local lua_activity130_oper_group = {}
local fields = {
	operGroupId = 2,
	descImg = 5,
	name = 9,
	operDesc = 4,
	operType = 3,
	audioId = 8,
	shapegetImg = 7,
	shapeImg = 6,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"operGroupId",
	"operType"
}
local mlStringKey = {
	name = 2,
	operDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity130_oper_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity130_oper_group, "configList", _configList)
	rawset(lua_activity130_oper_group, "configDict", _configDict)
end

setmetatable(lua_activity130_oper_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity130_oper_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity130_oper_group, "configList", nil)
	rawset(lua_activity130_oper_group, "configDict", nil)
end

return lua_activity130_oper_group
