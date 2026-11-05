-- chunkname: @modules/configs/excel2json/lua_fight_effect_group.lua

module("modules.configs.excel2json.lua_fight_effect_group", package.seeall)

local lua_fight_effect_group = {}
local fields = {
	id = 1,
	career = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_effect_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_effect_group, "configList", _configList)
	rawset(lua_fight_effect_group, "configDict", _configDict)
end

setmetatable(lua_fight_effect_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_effect_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_effect_group, "configList", nil)
	rawset(lua_fight_effect_group, "configDict", nil)
end

return lua_fight_effect_group
