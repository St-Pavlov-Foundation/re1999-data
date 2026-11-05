-- chunkname: @modules/configs/excel2json/lua_balance_umbrella.lua

module("modules.configs.excel2json.lua_balance_umbrella", package.seeall)

local lua_balance_umbrella = {}
local fields = {
	players = 5,
	name = 3,
	id = 1,
	episode = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	players = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.balance_umbrella_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_balance_umbrella, "configList", _configList)
	rawset(lua_balance_umbrella, "configDict", _configDict)
end

setmetatable(lua_balance_umbrella, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_balance_umbrella.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_balance_umbrella, "configList", nil)
	rawset(lua_balance_umbrella, "configDict", nil)
end

return lua_balance_umbrella
