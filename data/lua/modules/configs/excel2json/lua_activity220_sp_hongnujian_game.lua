-- chunkname: @modules/configs/excel2json/lua_activity220_sp_hongnujian_game.lua

module("modules.configs.excel2json.lua_activity220_sp_hongnujian_game", package.seeall)

local lua_activity220_sp_hongnujian_game = {}
local fields = {
	winDesc = 9,
	isGravity = 11,
	time = 3,
	res = 12,
	winType = 7,
	lifeShow = 6,
	monsterTeam = 4,
	isEnergy = 10,
	life = 5,
	id = 2,
	winParam = 8,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	winDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_sp_hongnujian_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_sp_hongnujian_game, "configList", _configList)
	rawset(lua_activity220_sp_hongnujian_game, "configDict", _configDict)
end

setmetatable(lua_activity220_sp_hongnujian_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_sp_hongnujian_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_sp_hongnujian_game, "configList", nil)
	rawset(lua_activity220_sp_hongnujian_game, "configDict", nil)
end

return lua_activity220_sp_hongnujian_game
