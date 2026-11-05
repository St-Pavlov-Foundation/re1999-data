-- chunkname: @modules/configs/excel2json/lua_odyssey_level.lua

module("modules.configs.excel2json.lua_odyssey_level", package.seeall)

local lua_odyssey_level = {}
local fields = {
	needExp = 2,
	reward = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.odyssey_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_level, "configList", _configList)
	rawset(lua_odyssey_level, "configDict", _configDict)
end

setmetatable(lua_odyssey_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_level, "configList", nil)
	rawset(lua_odyssey_level, "configDict", nil)
end

return lua_odyssey_level
