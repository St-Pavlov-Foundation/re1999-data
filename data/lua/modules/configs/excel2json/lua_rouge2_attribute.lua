-- chunkname: @modules/configs/excel2json/lua_rouge2_attribute.lua

module("modules.configs.excel2json.lua_rouge2_attribute", package.seeall)

local lua_rouge2_attribute = {}
local fields = {
	name = 2,
	spriteIndex = 6,
	exAttrLimit = 3,
	type = 7,
	min = 9,
	showMax = 10,
	careerDesc = 4,
	id = 1,
	icon = 5,
	level = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	careerDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_attribute, "configList", _configList)
	rawset(lua_rouge2_attribute, "configDict", _configDict)
end

setmetatable(lua_rouge2_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_attribute, "configList", nil)
	rawset(lua_rouge2_attribute, "configDict", nil)
end

return lua_rouge2_attribute
