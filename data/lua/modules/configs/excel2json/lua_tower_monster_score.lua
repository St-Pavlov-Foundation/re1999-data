-- chunkname: @modules/configs/excel2json/lua_tower_monster_score.lua

module("modules.configs.excel2json.lua_tower_monster_score", package.seeall)

local lua_tower_monster_score = {}
local fields = {
	killScore = 3,
	monsterId = 1,
	hpPerScore = 2
}
local primaryKey = {
	"monsterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_monster_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_monster_score, "configList", _configList)
	rawset(lua_tower_monster_score, "configDict", _configDict)
end

setmetatable(lua_tower_monster_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_monster_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_monster_score, "configList", nil)
	rawset(lua_tower_monster_score, "configDict", nil)
end

return lua_tower_monster_score
