-- chunkname: @modules/configs/excel2json/lua_atomic_map_info.lua

module("modules.configs.excel2json.lua_atomic_map_info", package.seeall)

local lua_atomic_map_info = {}
local fields = {
	initPos = 3,
	res = 2,
	lightRot = 5,
	type = 9,
	unlockDesc = 8,
	lightColor = 6,
	mapName = 7,
	id = 1,
	initRot = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 2,
	mapName = 1
}
local _configList, _configDict
local configPath = "configs.atomic_map_info_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_map_info, "configList", _configList)
	rawset(lua_atomic_map_info, "configDict", _configDict)
end

setmetatable(lua_atomic_map_info, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_map_info.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_map_info, "configList", nil)
	rawset(lua_atomic_map_info, "configDict", nil)
end

return lua_atomic_map_info
