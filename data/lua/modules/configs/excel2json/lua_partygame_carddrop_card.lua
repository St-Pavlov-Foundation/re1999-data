-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_card.lua

module("modules.configs.excel2json.lua_partygame_carddrop_card", package.seeall)

local lua_partygame_carddrop_card = {}
local fields = {
	variantType = 3,
	id = 1,
	timeline = 6,
	type = 2,
	power = 4,
	order = 7,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.partygame_carddrop_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_carddrop_card, "configList", _configList)
	rawset(lua_partygame_carddrop_card, "configDict", _configDict)
end

setmetatable(lua_partygame_carddrop_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_carddrop_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_carddrop_card, "configList", nil)
	rawset(lua_partygame_carddrop_card, "configDict", nil)
end

return lua_partygame_carddrop_card
