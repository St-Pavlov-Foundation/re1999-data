-- chunkname: @modules/configs/excel2json/lua_monster_sub.lua

module("modules.configs.excel2json.lua_monster_sub", package.seeall)

local lua_monster_sub = {}
local fields = {
	score = 3,
	life = 4,
	technic = 8,
	job = 2,
	id = 1,
	defense = 6,
	mdefense = 7,
	attack = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.monster_sub_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_sub, "configList", _configList)
	rawset(lua_monster_sub, "configDict", _configDict)
end

setmetatable(lua_monster_sub, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_sub.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_sub, "configList", nil)
	rawset(lua_monster_sub, "configDict", nil)
end

return lua_monster_sub
