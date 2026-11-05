-- chunkname: @modules/configs/excel2json/lua_odyssey_level_suppress.lua

module("modules.configs.excel2json.lua_odyssey_level_suppress", package.seeall)

local lua_odyssey_level_suppress = {}
local fields = {
	id = 1,
	hiddenRule = 3,
	levelDifference = 2,
	tips = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_level_suppress_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_level_suppress, "configList", _configList)
	rawset(lua_odyssey_level_suppress, "configDict", _configDict)
end

setmetatable(lua_odyssey_level_suppress, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_level_suppress.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_level_suppress, "configList", nil)
	rawset(lua_odyssey_level_suppress, "configDict", nil)
end

return lua_odyssey_level_suppress
