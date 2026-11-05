-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf_add_card.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf_add_card", package.seeall)

local lua_fight_sp_effect_alf_add_card = {}
local fields = {
	effect = 2,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_alf_add_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_alf_add_card, "configList", _configList)
	rawset(lua_fight_sp_effect_alf_add_card, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_alf_add_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_alf_add_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_alf_add_card, "configList", nil)
	rawset(lua_fight_sp_effect_alf_add_card, "configDict", nil)
end

return lua_fight_sp_effect_alf_add_card
