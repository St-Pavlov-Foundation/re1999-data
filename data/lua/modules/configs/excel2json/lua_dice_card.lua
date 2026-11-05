-- chunkname: @modules/configs/excel2json/lua_dice_card.lua

module("modules.configs.excel2json.lua_dice_card", package.seeall)

local lua_dice_card = {}
local fields = {
	effect1 = 6,
	bufflist = 16,
	name = 2,
	type = 5,
	effect3 = 12,
	aim1 = 8,
	aim3 = 14,
	desc = 3,
	allRoundLimitCount = 18,
	params2 = 10,
	roundLimitCount = 17,
	effect2 = 9,
	patternlist = 15,
	quality = 4,
	spiritskilltype = 19,
	aim2 = 11,
	powerExtendRule = 20,
	params3 = 13,
	id = 1,
	params1 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.dice_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_card, "configList", _configList)
	rawset(lua_dice_card, "configDict", _configDict)
end

setmetatable(lua_dice_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_card, "configList", nil)
	rawset(lua_dice_card, "configDict", nil)
end

return lua_dice_card
