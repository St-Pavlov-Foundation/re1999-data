-- chunkname: @modules/configs/excel2json/lua_tower_compose_base.lua

module("modules.configs.excel2json.lua_tower_compose_base", package.seeall)

local lua_tower_compose_base = {}
local fields = {
	bossId = 3,
	isOnline = 7,
	themeIcon = 6,
	name = 4,
	supportHeroIds = 11,
	partIds = 9,
	extraHeroIds = 12,
	researchIds = 13,
	tagIds = 10,
	researchTaskGroupId = 2,
	auraIds = 8,
	themeId = 1,
	nameEn = 5
}
local primaryKey = {
	"themeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_compose_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_base, "configList", _configList)
	rawset(lua_tower_compose_base, "configDict", _configDict)
end

setmetatable(lua_tower_compose_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_base, "configList", nil)
	rawset(lua_tower_compose_base, "configDict", nil)
end

return lua_tower_compose_base
