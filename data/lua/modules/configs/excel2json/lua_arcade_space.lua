-- chunkname: @modules/configs/excel2json/lua_arcade_space.lua

module("modules.configs.excel2json.lua_arcade_space", package.seeall)

local lua_arcade_space = {}
local fields = {
	nodePortal6 = 9,
	firstRoom = 3,
	nodePortal1 = 4,
	nodePortal8 = 11,
	nodePortal2 = 5,
	nodePortal3 = 6,
	nodePortal4 = 7,
	nodePortal5 = 8,
	id = 1,
	node = 2,
	nodePortal7 = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_space_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_space, "configList", _configList)
	rawset(lua_arcade_space, "configDict", _configDict)
end

setmetatable(lua_arcade_space, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_space.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_space, "configList", nil)
	rawset(lua_arcade_space, "configDict", nil)
end

return lua_arcade_space
