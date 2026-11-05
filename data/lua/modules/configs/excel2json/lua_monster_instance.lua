-- chunkname: @modules/configs/excel2json/lua_monster_instance.lua

module("modules.configs.excel2json.lua_monster_instance", package.seeall)

local lua_monster_instance = {}
local fields = {
	defense = 4,
	id = 1,
	technic = 6,
	mdefense = 5,
	sub = 8,
	multiHp = 9,
	life = 2,
	attack = 3,
	level = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.monster_instance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_instance, "configList", _configList)
	rawset(lua_monster_instance, "configDict", _configDict)
end

setmetatable(lua_monster_instance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_instance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_instance, "configList", nil)
	rawset(lua_monster_instance, "configDict", nil)
end

return lua_monster_instance
