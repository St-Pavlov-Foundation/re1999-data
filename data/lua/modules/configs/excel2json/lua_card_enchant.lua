-- chunkname: @modules/configs/excel2json/lua_card_enchant.lua

module("modules.configs.excel2json.lua_card_enchant", package.seeall)

local lua_card_enchant = {}
local fields = {
	extraKeys = 8,
	id = 1,
	coverType = 2,
	rejectTypes = 4,
	desc = 9,
	feature = 7,
	excludeTypes = 3,
	stage = 5,
	decStage = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.card_enchant_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_card_enchant, "configList", _configList)
	rawset(lua_card_enchant, "configDict", _configDict)
end

setmetatable(lua_card_enchant, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_card_enchant.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_card_enchant, "configList", nil)
	rawset(lua_card_enchant, "configDict", nil)
end

return lua_card_enchant
