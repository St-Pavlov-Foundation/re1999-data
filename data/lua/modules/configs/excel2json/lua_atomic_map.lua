-- chunkname: @modules/configs/excel2json/lua_atomic_map.lua

module("modules.configs.excel2json.lua_atomic_map", package.seeall)

local lua_atomic_map = {}
local fields = {
	maptype = 5,
	arenaId = 2,
	infoId = 4,
	id = 1,
	unlockCondition = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.atomic_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_map, "configList", _configList)
	rawset(lua_atomic_map, "configDict", _configDict)
end

setmetatable(lua_atomic_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_map, "configList", nil)
	rawset(lua_atomic_map, "configDict", nil)
end

return lua_atomic_map
