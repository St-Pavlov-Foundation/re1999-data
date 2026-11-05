-- chunkname: @modules/configs/excel2json/lua_month_card_added.lua

module("modules.configs.excel2json.lua_month_card_added", package.seeall)

local lua_month_card_added = {}
local fields = {
	overMaxDayBonus = 6,
	signingItem = 9,
	signatureDays = 8,
	days = 4,
	limit = 5,
	onceBonus = 3,
	itemSource = 7,
	id = 1,
	month_id = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.month_card_added_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_month_card_added, "configList", _configList)
	rawset(lua_month_card_added, "configDict", _configDict)
end

setmetatable(lua_month_card_added, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_month_card_added.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_month_card_added, "configList", nil)
	rawset(lua_month_card_added, "configDict", nil)
end

return lua_month_card_added
