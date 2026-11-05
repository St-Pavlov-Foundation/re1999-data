-- chunkname: @modules/configs/excel2json/lua_activity188_card.lua

module("modules.configs.excel2json.lua_activity188_card", package.seeall)

local lua_activity188_card = {}
local fields = {
	cardId = 2,
	name = 5,
	skillId = 4,
	type = 3,
	resource = 7,
	activityId = 1,
	desc = 6
}
local primaryKey = {
	"activityId",
	"cardId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity188_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_card, "configList", _configList)
	rawset(lua_activity188_card, "configDict", _configDict)
end

setmetatable(lua_activity188_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_card, "configList", nil)
	rawset(lua_activity188_card, "configDict", nil)
end

return lua_activity188_card
