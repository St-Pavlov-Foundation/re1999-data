-- chunkname: @modules/configs/excel2json/lua_copost_decoration_coordinates.lua

module("modules.configs.excel2json.lua_copost_decoration_coordinates", package.seeall)

local lua_copost_decoration_coordinates = {}
local fields = {
	rotate = 4,
	coordinates = 2,
	id = 1,
	scale = 3,
	decorationId = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_decoration_coordinates_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_decoration_coordinates, "configList", _configList)
	rawset(lua_copost_decoration_coordinates, "configDict", _configDict)
end

setmetatable(lua_copost_decoration_coordinates, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_decoration_coordinates.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_decoration_coordinates, "configList", nil)
	rawset(lua_copost_decoration_coordinates, "configDict", nil)
end

return lua_copost_decoration_coordinates
