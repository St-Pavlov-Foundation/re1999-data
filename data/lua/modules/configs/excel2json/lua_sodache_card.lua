-- chunkname: @modules/configs/excel2json/lua_sodache_card.lua

module("modules.configs.excel2json.lua_sodache_card", package.seeall)

local lua_sodache_card = {}
local fields = {
	dropWeight = 9,
	name = 2,
	funcDesc = 4,
	type = 7,
	diceList = 20,
	dropPrice = 8,
	desc = 3,
	disappear = 14,
	subType = 10,
	refrain = 21,
	icon = 6,
	price = 11,
	cost = 12,
	quality = 5,
	useDesc = 18,
	additionRule = 22,
	bagSkillIds = 19,
	maxStack = 15,
	directUse = 16,
	useEffect = 17,
	id = 1,
	takeOut = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	funcDesc = 3,
	name = 1,
	useDesc = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.sodache_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_card, "configList", _configList)
	rawset(lua_sodache_card, "configDict", _configDict)
end

setmetatable(lua_sodache_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_card, "configList", nil)
	rawset(lua_sodache_card, "configDict", nil)
end

return lua_sodache_card
