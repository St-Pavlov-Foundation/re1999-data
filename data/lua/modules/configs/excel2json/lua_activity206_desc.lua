-- chunkname: @modules/configs/excel2json/lua_activity206_desc.lua

module("modules.configs.excel2json.lua_activity206_desc", package.seeall)

local lua_activity206_desc = {}
local fields = {
	stageId = 2,
	name = 3,
	targetDesc = 5,
	ruleTitle = 6,
	ruleDesc = 7,
	icon = 8,
	activityId = 1,
	desc = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {
	ruleTitle = 4,
	name = 1,
	ruleDesc = 5,
	targetDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity206_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity206_desc, "configList", _configList)
	rawset(lua_activity206_desc, "configDict", _configDict)
end

setmetatable(lua_activity206_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity206_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity206_desc, "configList", nil)
	rawset(lua_activity206_desc, "configDict", nil)
end

return lua_activity206_desc
