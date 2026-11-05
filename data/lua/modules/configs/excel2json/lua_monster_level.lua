-- chunkname: @modules/configs/excel2json/lua_monster_level.lua

module("modules.configs.excel2json.lua_monster_level", package.seeall)

local lua_monster_level = {}
local fields = {
	equip_base = 5,
	equip_super = 6,
	technic = 3,
	base = 2,
	id = 1,
	base_super = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.monster_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_level, "configList", _configList)
	rawset(lua_monster_level, "configDict", _configDict)
end

setmetatable(lua_monster_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_level, "configList", nil)
	rawset(lua_monster_level, "configDict", nil)
end

return lua_monster_level
