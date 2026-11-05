-- chunkname: @modules/configs/excel2json/lua_achievement_group.lua

module("modules.configs.excel2json.lua_achievement_group", package.seeall)

local lua_achievement_group = {}
local fields = {
	uiListParam = 6,
	name = 4,
	desc = 5,
	category = 2,
	id = 1,
	unLockAchievement = 8,
	uiPlayerParam = 7,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.achievement_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_achievement_group, "configList", _configList)
	rawset(lua_achievement_group, "configDict", _configDict)
end

setmetatable(lua_achievement_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_achievement_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_achievement_group, "configList", nil)
	rawset(lua_achievement_group, "configDict", nil)
end

return lua_achievement_group
