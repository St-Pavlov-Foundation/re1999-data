-- chunkname: @modules/configs/excel2json/lua_siege_battle_const.lua

module("modules.configs.excel2json.lua_siege_battle_const", package.seeall)

local lua_siege_battle_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.siege_battle_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_siege_battle_const, "configList", _configList)
	rawset(lua_siege_battle_const, "configDict", _configDict)
end

setmetatable(lua_siege_battle_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_siege_battle_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_siege_battle_const, "configList", nil)
	rawset(lua_siege_battle_const, "configDict", nil)
end

return lua_siege_battle_const
