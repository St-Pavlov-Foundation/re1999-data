-- chunkname: @modules/configs/excel2json/lua_assassin_monster.lua

module("modules.configs.excel2json.lua_assassin_monster", package.seeall)

local lua_assassin_monster = {}
local fields = {
	param = 3,
	boss = 5,
	scanRate = 4,
	type = 2,
	position = 9,
	icon = 10,
	rule = 7,
	posOrder = 11,
	model = 6,
	id = 1,
	notMove = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_monster, "configList", _configList)
	rawset(lua_assassin_monster, "configDict", _configDict)
end

setmetatable(lua_assassin_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_monster, "configList", nil)
	rawset(lua_assassin_monster, "configDict", nil)
end

return lua_assassin_monster
