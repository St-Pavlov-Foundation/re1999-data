-- chunkname: @modules/configs/excel2json/lua_odyssey_map.lua

module("modules.configs.excel2json.lua_odyssey_map", package.seeall)

local lua_odyssey_map = {}
local fields = {
	unlockCondition = 2,
	res = 3,
	mapName = 5,
	recommendLevel = 6,
	id = 1,
	initPos = 4,
	unlockDesc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 2,
	mapName = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_map, "configList", _configList)
	rawset(lua_odyssey_map, "configDict", _configDict)
end

setmetatable(lua_odyssey_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_map, "configList", nil)
	rawset(lua_odyssey_map, "configDict", nil)
end

return lua_odyssey_map
