-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_pack.lua

module("modules.configs.excel2json.lua_arcade_survivor_pack", package.seeall)

local lua_arcade_survivor_pack = {}
local fields = {
	optionCount = 7,
	rarity = 5,
	name = 2,
	prices = 6,
	rerollCount = 8,
	desc = 4,
	rarityWeights = 9,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_pack_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_pack, "configList", _configList)
	rawset(lua_arcade_survivor_pack, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_pack, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_pack.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_pack, "configList", nil)
	rawset(lua_arcade_survivor_pack, "configDict", nil)
end

return lua_arcade_survivor_pack
