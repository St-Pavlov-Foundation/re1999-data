-- chunkname: @modules/configs/excel2json/lua_activity220_sp_hongnujian_monster.lua

module("modules.configs.excel2json.lua_activity220_sp_hongnujian_monster", package.seeall)

local lua_activity220_sp_hongnujian_monster = {}
local fields = {
	life = 6,
	radius = 12,
	waveTime = 4,
	type = 8,
	group = 3,
	pos = 5,
	move = 11,
	speed = 9,
	res = 10,
	atk = 7,
	id = 1,
	monster = 2
}
local primaryKey = {
	"id",
	"monster"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_sp_hongnujian_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_sp_hongnujian_monster, "configList", _configList)
	rawset(lua_activity220_sp_hongnujian_monster, "configDict", _configDict)
end

setmetatable(lua_activity220_sp_hongnujian_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_sp_hongnujian_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_sp_hongnujian_monster, "configList", nil)
	rawset(lua_activity220_sp_hongnujian_monster, "configDict", nil)
end

return lua_activity220_sp_hongnujian_monster
