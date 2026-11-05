-- chunkname: @modules/configs/excel2json/lua_odyssey_const.lua

module("modules.configs.excel2json.lua_odyssey_const", package.seeall)

local lua_odyssey_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.odyssey_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_const, "configList", _configList)
	rawset(lua_odyssey_const, "configDict", _configDict)
end

setmetatable(lua_odyssey_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_const, "configList", nil)
	rawset(lua_odyssey_const, "configDict", nil)
end

return lua_odyssey_const
