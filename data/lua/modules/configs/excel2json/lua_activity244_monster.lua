-- chunkname: @modules/configs/excel2json/lua_activity244_monster.lua

module("modules.configs.excel2json.lua_activity244_monster", package.seeall)

local lua_activity244_monster = {}
local fields = {
	mesh = 7,
	name = 2,
	skillTemplate = 4,
	image = 6,
	career = 8,
	template = 3,
	id = 1,
	icon = 5,
	level = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity244_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_monster, "configList", _configList)
	rawset(lua_activity244_monster, "configDict", _configDict)
end

setmetatable(lua_activity244_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_monster, "configList", nil)
	rawset(lua_activity244_monster, "configDict", nil)
end

return lua_activity244_monster
