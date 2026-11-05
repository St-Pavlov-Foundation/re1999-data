-- chunkname: @modules/configs/excel2json/lua_fight_move_const.lua

module("modules.configs.excel2json.lua_fight_move_const", package.seeall)

local lua_fight_move_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_move_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_move_const, "configList", _configList)
	rawset(lua_fight_move_const, "configDict", _configDict)
end

setmetatable(lua_fight_move_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_move_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_move_const, "configList", nil)
	rawset(lua_fight_move_const, "configDict", nil)
end

return lua_fight_move_const
