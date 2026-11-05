-- chunkname: @modules/configs/excel2json/lua_fight_next_round_get_card.lua

module("modules.configs.excel2json.lua_fight_next_round_get_card", package.seeall)

local lua_fight_next_round_get_card = {}
local fields = {
	exclusion = 5,
	priority = 2,
	tempCard = 6,
	skillId = 4,
	id = 1,
	condition = 3
}
local primaryKey = {
	"id",
	"priority"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_next_round_get_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_next_round_get_card, "configList", _configList)
	rawset(lua_fight_next_round_get_card, "configDict", _configDict)
end

setmetatable(lua_fight_next_round_get_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_next_round_get_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_next_round_get_card, "configList", nil)
	rawset(lua_fight_next_round_get_card, "configDict", nil)
end

return lua_fight_next_round_get_card
