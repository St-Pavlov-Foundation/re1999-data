-- chunkname: @modules/configs/excel2json/lua_tower_boss.lua

module("modules.configs.excel2json.lua_tower_boss", package.seeall)

local lua_tower_boss = {}
local fields = {
	bossId = 2,
	name = 3,
	nameEn = 4,
	towerId = 1
}
local primaryKey = {
	"towerId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_boss_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_boss, "configList", _configList)
	rawset(lua_tower_boss, "configDict", _configDict)
end

setmetatable(lua_tower_boss, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_boss.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_boss, "configList", nil)
	rawset(lua_tower_boss, "configDict", nil)
end

return lua_tower_boss
