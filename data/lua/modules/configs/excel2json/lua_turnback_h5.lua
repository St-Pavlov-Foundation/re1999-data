-- chunkname: @modules/configs/excel2json/lua_turnback_h5.lua

module("modules.configs.excel2json.lua_turnback_h5", package.seeall)

local lua_turnback_h5 = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_h5_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_h5, "configList", _configList)
	rawset(lua_turnback_h5, "configDict", _configDict)
end

setmetatable(lua_turnback_h5, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_h5.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_h5, "configList", nil)
	rawset(lua_turnback_h5, "configDict", nil)
end

return lua_turnback_h5
