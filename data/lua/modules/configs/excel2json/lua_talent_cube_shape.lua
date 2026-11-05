-- chunkname: @modules/configs/excel2json/lua_talent_cube_shape.lua

module("modules.configs.excel2json.lua_talent_cube_shape", package.seeall)

local lua_talent_cube_shape = {}
local fields = {
	id = 1,
	shape = 2,
	icon = 4,
	sort = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.talent_cube_shape_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_cube_shape, "configList", _configList)
	rawset(lua_talent_cube_shape, "configDict", _configDict)
end

setmetatable(lua_talent_cube_shape, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_cube_shape.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_cube_shape, "configList", nil)
	rawset(lua_talent_cube_shape, "configDict", nil)
end

return lua_talent_cube_shape
