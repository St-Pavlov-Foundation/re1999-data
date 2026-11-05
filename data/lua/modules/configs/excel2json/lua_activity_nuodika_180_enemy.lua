-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_enemy.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_enemy", package.seeall)

local lua_activity_nuodika_180_enemy = {}
local fields = {
	enemyId = 1,
	name = 2,
	eventID = 10,
	main = 6,
	mapID = 11,
	picture = 4,
	desc = 3,
	skillID = 9,
	hp = 7,
	atk = 8,
	pictureOffset = 5
}
local primaryKey = {
	"enemyId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity_nuodika_180_enemy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_nuodika_180_enemy, "configList", _configList)
	rawset(lua_activity_nuodika_180_enemy, "configDict", _configDict)
end

setmetatable(lua_activity_nuodika_180_enemy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_nuodika_180_enemy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_nuodika_180_enemy, "configList", nil)
	rawset(lua_activity_nuodika_180_enemy, "configDict", nil)
end

return lua_activity_nuodika_180_enemy
