-- chunkname: @modules/configs/excel2json/lua_activity246_card.lua

module("modules.configs.excel2json.lua_activity246_card", package.seeall)

local lua_activity246_card = {}
local fields = {
	reward = 4,
	cardId = 1,
	row = 2,
	finalReward = 5,
	column = 3
}
local primaryKey = {
	"cardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity246_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity246_card, "configList", _configList)
	rawset(lua_activity246_card, "configDict", _configDict)
end

setmetatable(lua_activity246_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity246_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity246_card, "configList", nil)
	rawset(lua_activity246_card, "configDict", nil)
end

return lua_activity246_card
