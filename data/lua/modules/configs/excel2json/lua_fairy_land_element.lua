-- chunkname: @modules/configs/excel2json/lua_fairy_land_element.lua

module("modules.configs.excel2json.lua_fairy_land_element", package.seeall)

local lua_fairy_land_element = {}
local fields = {
	id = 1,
	puzzleId = 4,
	pos = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fairy_land_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fairy_land_element, "configList", _configList)
	rawset(lua_fairy_land_element, "configDict", _configDict)
end

setmetatable(lua_fairy_land_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fairy_land_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fairy_land_element, "configList", nil)
	rawset(lua_fairy_land_element, "configDict", nil)
end

return lua_fairy_land_element
