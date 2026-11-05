-- chunkname: @modules/configs/excel2json/lua_fight_entity_summoned_replace_by_skin.lua

module("modules.configs.excel2json.lua_fight_entity_summoned_replace_by_skin", package.seeall)

local lua_fight_entity_summoned_replace_by_skin = {}
local fields = {
	keyForEntiySummon = 1,
	keyForEntiySummonSkinId = 3,
	skinId = 2
}
local primaryKey = {
	"keyForEntiySummon",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_entity_summoned_replace_by_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_entity_summoned_replace_by_skin, "configList", _configList)
	rawset(lua_fight_entity_summoned_replace_by_skin, "configDict", _configDict)
end

setmetatable(lua_fight_entity_summoned_replace_by_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_entity_summoned_replace_by_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_entity_summoned_replace_by_skin, "configList", nil)
	rawset(lua_fight_entity_summoned_replace_by_skin, "configDict", nil)
end

return lua_fight_entity_summoned_replace_by_skin
