-- chunkname: @modules/configs/excel2json/lua_fight_monster_3d.lua

module("modules.configs.excel2json.lua_fight_monster_3d", package.seeall)

local lua_fight_monster_3d = {}
local fields = {
	sizeForScale = 5,
	buffId2hang = 4,
	id = 1,
	size = 3,
	hangMap = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_monster_3d_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_monster_3d, "configList", _configList)
	rawset(lua_fight_monster_3d, "configDict", _configDict)
end

setmetatable(lua_fight_monster_3d, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_monster_3d.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_monster_3d, "configList", nil)
	rawset(lua_fight_monster_3d, "configDict", nil)
end

return lua_fight_monster_3d
