-- chunkname: @modules/configs/excel2json/lua_tower_boss_teach.lua

module("modules.configs.excel2json.lua_tower_boss_teach", package.seeall)

local lua_tower_boss_teach = {}
local fields = {
	episodeId = 3,
	name = 6,
	desc = 7,
	teachId = 2,
	firstBonus = 4,
	planId = 5,
	towerId = 1
}
local primaryKey = {
	"towerId",
	"teachId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_boss_teach_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_boss_teach, "configList", _configList)
	rawset(lua_tower_boss_teach, "configDict", _configDict)
end

setmetatable(lua_tower_boss_teach, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_boss_teach.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_boss_teach, "configList", nil)
	rawset(lua_tower_boss_teach, "configDict", nil)
end

return lua_tower_boss_teach
