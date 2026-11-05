-- chunkname: @modules/configs/excel2json/lua_fight_effect_follow_entity_visible.lua

module("modules.configs.excel2json.lua_fight_effect_follow_entity_visible", package.seeall)

local lua_fight_effect_follow_entity_visible = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_effect_follow_entity_visible_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_effect_follow_entity_visible, "configList", _configList)
	rawset(lua_fight_effect_follow_entity_visible, "configDict", _configDict)
end

setmetatable(lua_fight_effect_follow_entity_visible, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_effect_follow_entity_visible.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_effect_follow_entity_visible, "configList", nil)
	rawset(lua_fight_effect_follow_entity_visible, "configDict", nil)
end

return lua_fight_effect_follow_entity_visible
