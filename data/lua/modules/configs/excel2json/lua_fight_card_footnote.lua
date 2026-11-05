-- chunkname: @modules/configs/excel2json/lua_fight_card_footnote.lua

module("modules.configs.excel2json.lua_fight_card_footnote", package.seeall)

local lua_fight_card_footnote = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.fight_card_footnote_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_card_footnote, "configList", _configList)
	rawset(lua_fight_card_footnote, "configDict", _configDict)
end

setmetatable(lua_fight_card_footnote, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_card_footnote.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_card_footnote, "configList", nil)
	rawset(lua_fight_card_footnote, "configDict", nil)
end

return lua_fight_card_footnote
