-- chunkname: @modules/configs/excel2json/lua_month_card.lua

module("modules.configs.excel2json.lua_month_card", package.seeall)

local lua_month_card = {}
local fields = {
	dailyBonus = 4,
	signingItem = 9,
	signatureDays = 8,
	days = 2,
	onceBonus = 3,
	itemSource = 7,
	id = 1,
	maxDaysLimit = 5,
	overMaxDayBonus = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.month_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_month_card, "configList", _configList)
	rawset(lua_month_card, "configDict", _configDict)
end

setmetatable(lua_month_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_month_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_month_card, "configList", nil)
	rawset(lua_month_card, "configDict", nil)
end

return lua_month_card
