-- chunkname: @modules/configs/excel2json/lua_udimo_decoration.lua

module("modules.configs.excel2json.lua_udimo_decoration", package.seeall)

local lua_udimo_decoration = {}
local fields = {
	defaultUse = 5,
	name = 2,
	img = 3,
	id = 1,
	isDefault = 4,
	airPoints = 8,
	pos = 6,
	resource = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.udimo_decoration_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_decoration, "configList", _configList)
	rawset(lua_udimo_decoration, "configDict", _configDict)
end

setmetatable(lua_udimo_decoration, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_decoration.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_decoration, "configList", nil)
	rawset(lua_udimo_decoration, "configDict", nil)
end

return lua_udimo_decoration
