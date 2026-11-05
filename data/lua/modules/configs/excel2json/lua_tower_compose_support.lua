-- chunkname: @modules/configs/excel2json/lua_tower_compose_support.lua

module("modules.configs.excel2json.lua_tower_compose_support", package.seeall)

local lua_tower_compose_support = {}
local fields = {
	resMaxVal = 13,
	heroTag = 6,
	id = 1,
	activeSkills = 9,
	passiveSkills = 10,
	resInitVal = 12,
	extraRule = 11,
	desc = 7,
	activeType = 5,
	heroId = 2,
	themeId = 3,
	coldTime = 8,
	lv = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.tower_compose_support_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_support, "configList", _configList)
	rawset(lua_tower_compose_support, "configDict", _configDict)
end

setmetatable(lua_tower_compose_support, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_support.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_support, "configList", nil)
	rawset(lua_tower_compose_support, "configDict", nil)
end

return lua_tower_compose_support
