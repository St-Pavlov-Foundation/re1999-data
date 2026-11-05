-- chunkname: @modules/configs/excel2json/lua_activity114_attribute.lua

module("modules.configs.excel2json.lua_activity114_attribute", package.seeall)

local lua_activity114_attribute = {}
local fields = {
	attrName = 4,
	educationAttentionConsts = 6,
	attributeNum = 5,
	id = 2,
	activityId = 1,
	attribute = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	attrName = 1
}
local _configList, _configDict
local configPath = "configs.activity114_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_attribute, "configList", _configList)
	rawset(lua_activity114_attribute, "configDict", _configDict)
end

setmetatable(lua_activity114_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_attribute, "configList", nil)
	rawset(lua_activity114_attribute, "configDict", nil)
end

return lua_activity114_attribute
