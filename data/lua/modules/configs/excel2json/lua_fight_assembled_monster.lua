-- chunkname: @modules/configs/excel2json/lua_fight_assembled_monster.lua

module("modules.configs.excel2json.lua_fight_assembled_monster", package.seeall)

local lua_fight_assembled_monster = {}
local fields = {
	clickIndex = 6,
	virtualStance = 3,
	part = 2,
	hpPos = 8,
	id = 1,
	virtualSpineSize = 5,
	selectPos = 7,
	virtualSpinePos = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_assembled_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_assembled_monster, "configList", _configList)
	rawset(lua_fight_assembled_monster, "configDict", _configDict)
end

setmetatable(lua_fight_assembled_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_assembled_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_assembled_monster, "configList", nil)
	rawset(lua_fight_assembled_monster, "configDict", nil)
end

return lua_fight_assembled_monster
