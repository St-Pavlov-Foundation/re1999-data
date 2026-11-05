-- chunkname: @modules/configs/excel2json/lua_activity205_card.lua

module("modules.configs.excel2json.lua_activity205_card", package.seeall)

local lua_activity205_card = {}
local fields = {
	restrain = 6,
	name = 3,
	type = 2,
	subWeight = 9,
	desc = 4,
	img = 5,
	id = 1,
	spEff = 7,
	weight = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity205_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity205_card, "configList", _configList)
	rawset(lua_activity205_card, "configDict", _configDict)
end

setmetatable(lua_activity205_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity205_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity205_card, "configList", nil)
	rawset(lua_activity205_card, "configDict", nil)
end

return lua_activity205_card
