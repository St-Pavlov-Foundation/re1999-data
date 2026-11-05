-- chunkname: @modules/configs/excel2json/lua_fight_move_skillgroup.lua

module("modules.configs.excel2json.lua_fight_move_skillgroup", package.seeall)

local lua_fight_move_skillgroup = {}
local fields = {
	slot = 2,
	effect = 4,
	skillgroup = 5,
	id = 1,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_move_skillgroup_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_move_skillgroup, "configList", _configList)
	rawset(lua_fight_move_skillgroup, "configDict", _configDict)
end

setmetatable(lua_fight_move_skillgroup, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_move_skillgroup.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_move_skillgroup, "configList", nil)
	rawset(lua_fight_move_skillgroup, "configDict", nil)
end

return lua_fight_move_skillgroup
