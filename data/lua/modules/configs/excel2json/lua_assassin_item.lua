-- chunkname: @modules/configs/excel2json/lua_assassin_item.lua

module("modules.configs.excel2json.lua_assassin_item", package.seeall)

local lua_assassin_item = {}
local fields = {
	targetCheck = 15,
	name = 4,
	count = 6,
	roundLimit = 9,
	stealthEffDesc = 12,
	targetEff = 17,
	fightEffDesc = 11,
	unlock = 13,
	effect = 7,
	param = 8,
	itemType = 2,
	skillId = 18,
	icon = 5,
	level = 3,
	itemId = 1,
	range = 14,
	costPoint = 10,
	target = 16
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	fightEffDesc = 2,
	name = 1,
	stealthEffDesc = 3
}
local _configList, _configDict
local configPath = "configs.assassin_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_item, "configList", _configList)
	rawset(lua_assassin_item, "configDict", _configDict)
end

setmetatable(lua_assassin_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_item, "configList", nil)
	rawset(lua_assassin_item, "configDict", nil)
end

return lua_assassin_item
