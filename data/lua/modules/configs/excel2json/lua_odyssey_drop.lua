-- chunkname: @modules/configs/excel2json/lua_odyssey_drop.lua

module("modules.configs.excel2json.lua_odyssey_drop", package.seeall)

local lua_odyssey_drop = {}
local fields = {
	id = 1,
	dropRare = 2,
	dropNum = 4,
	dropSuit = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.odyssey_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_drop, "configList", _configList)
	rawset(lua_odyssey_drop, "configDict", _configDict)
end

setmetatable(lua_odyssey_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_drop, "configList", nil)
	rawset(lua_odyssey_drop, "configDict", nil)
end

return lua_odyssey_drop
