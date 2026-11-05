-- chunkname: @modules/configs/excel2json/lua_activity220_attribute.lua

module("modules.configs.excel2json.lua_activity220_attribute", package.seeall)

local lua_activity220_attribute = {}
local fields = {
	name = 2,
	min = 4,
	attrId = 1,
	special = 3,
	desc = 6,
	max = 5
}
local primaryKey = {
	"attrId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity220_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_attribute, "configList", _configList)
	rawset(lua_activity220_attribute, "configDict", _configDict)
end

setmetatable(lua_activity220_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_attribute, "configList", nil)
	rawset(lua_activity220_attribute, "configDict", nil)
end

return lua_activity220_attribute
