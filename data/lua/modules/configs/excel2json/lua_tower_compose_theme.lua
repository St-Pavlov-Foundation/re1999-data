-- chunkname: @modules/configs/excel2json/lua_tower_compose_theme.lua

module("modules.configs.excel2json.lua_tower_compose_theme", package.seeall)

local lua_tower_compose_theme = {}
local fields = {
	monsterGroupId = 3,
	name = 8,
	themeIcon = 10,
	nameEn = 9,
	modOffset = 5,
	spineOffset = 4,
	career = 14,
	isOnline = 13,
	orderLayer = 6,
	themeDesc = 11,
	modNum = 2,
	heroIds = 15,
	id = 1,
	pointIcon = 12,
	initEnv = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_compose_theme_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_theme, "configList", _configList)
	rawset(lua_tower_compose_theme, "configDict", _configDict)
end

setmetatable(lua_tower_compose_theme, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_theme.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_theme, "configList", nil)
	rawset(lua_tower_compose_theme, "configDict", nil)
end

return lua_tower_compose_theme
