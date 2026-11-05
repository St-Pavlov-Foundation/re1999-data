-- chunkname: @modules/configs/excel2json/lua_arcade_bomb.lua

module("modules.configs.excel2json.lua_arcade_bomb", package.seeall)

local lua_arcade_bomb = {}
local fields = {
	skillDesc = 3,
	name = 2,
	damage = 9,
	resPath = 5,
	skill = 13,
	skills = 14,
	target = 11,
	countdown = 10,
	addFloor = 12,
	icon = 15,
	alertEffectId = 6,
	effectDefault = 7,
	id = 1,
	shape = 4,
	scale = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_bomb_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_bomb, "configList", _configList)
	rawset(lua_arcade_bomb, "configDict", _configDict)
end

setmetatable(lua_arcade_bomb, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_bomb.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_bomb, "configList", nil)
	rawset(lua_arcade_bomb, "configDict", nil)
end

return lua_arcade_bomb
