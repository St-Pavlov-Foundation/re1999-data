-- chunkname: @modules/configs/excel2json/lua_fight_card_choice.lua

module("modules.configs.excel2json.lua_fight_card_choice", package.seeall)

local lua_fight_card_choice = {}
local fields = {
	id = 1,
	choiceSkIlls = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_card_choice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_card_choice, "configList", _configList)
	rawset(lua_fight_card_choice, "configDict", _configDict)
end

setmetatable(lua_fight_card_choice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_card_choice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_card_choice, "configList", nil)
	rawset(lua_fight_card_choice, "configDict", nil)
end

return lua_fight_card_choice
