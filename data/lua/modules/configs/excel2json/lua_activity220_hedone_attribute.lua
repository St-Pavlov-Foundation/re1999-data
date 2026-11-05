-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_attribute.lua

module("modules.configs.excel2json.lua_activity220_hedone_attribute", package.seeall)

local lua_activity220_hedone_attribute = {}
local fields = {
	defaultValue = 6,
	min = 4,
	attrId = 1,
	ownerType = 3,
	name = 2,
	max = 5
}
local primaryKey = {
	"attrId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity220_hedone_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_hedone_attribute, "configList", _configList)
	rawset(lua_activity220_hedone_attribute, "configDict", _configDict)
end

setmetatable(lua_activity220_hedone_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_hedone_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_hedone_attribute, "configList", nil)
	rawset(lua_activity220_hedone_attribute, "configDict", nil)
end

return lua_activity220_hedone_attribute
