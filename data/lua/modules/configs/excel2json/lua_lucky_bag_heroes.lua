-- chunkname: @modules/configs/excel2json/lua_lucky_bag_heroes.lua

module("modules.configs.excel2json.lua_lucky_bag_heroes", package.seeall)

local lua_lucky_bag_heroes = {}
local fields = {
	heroChoices = 3,
	name = 4,
	nameEn = 5,
	sceneIcon = 7,
	icon = 6,
	bagId = 2,
	poolId = 1
}
local primaryKey = {
	"poolId",
	"bagId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.lucky_bag_heroes_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_lucky_bag_heroes, "configList", _configList)
	rawset(lua_lucky_bag_heroes, "configDict", _configDict)
end

setmetatable(lua_lucky_bag_heroes, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_lucky_bag_heroes.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_lucky_bag_heroes, "configList", nil)
	rawset(lua_lucky_bag_heroes, "configDict", nil)
end

return lua_lucky_bag_heroes
