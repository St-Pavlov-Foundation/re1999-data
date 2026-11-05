-- chunkname: @modules/configs/excel2json/lua_activity126_dreamland_card.lua

module("modules.configs.excel2json.lua_activity126_dreamland_card", package.seeall)

local lua_activity126_dreamland_card = {}
local fields = {
	id = 1,
	desc = 4,
	activityId = 2,
	skillId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity126_dreamland_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity126_dreamland_card, "configList", _configList)
	rawset(lua_activity126_dreamland_card, "configDict", _configDict)
end

setmetatable(lua_activity126_dreamland_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity126_dreamland_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity126_dreamland_card, "configList", nil)
	rawset(lua_activity126_dreamland_card, "configDict", nil)
end

return lua_activity126_dreamland_card
