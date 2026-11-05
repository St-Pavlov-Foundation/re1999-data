-- chunkname: @modules/configs/excel2json/lua_racing_element.lua

module("modules.configs.excel2json.lua_racing_element", package.seeall)

local lua_racing_element = {}
local fields = {
	param = 5,
	prefab = 4,
	name = 2,
	type = 3,
	id = 1,
	icon = 8,
	refreshTime = 7,
	effect = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.racing_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_element, "configList", _configList)
	rawset(lua_racing_element, "configDict", _configDict)
end

setmetatable(lua_racing_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_element, "configList", nil)
	rawset(lua_racing_element, "configDict", nil)
end

return lua_racing_element
