-- chunkname: @modules/configs/excel2json/lua_achievement.lua

module("modules.configs.excel2json.lua_achievement", package.seeall)

local lua_achievement = {}
local fields = {
	startTime = 8,
	name = 5,
	endTime = 9,
	rule = 10,
	groupId = 3,
	uiPlayerParam = 6,
	category = 2,
	id = 1,
	isMask = 7,
	order = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.achievement_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_achievement, "configList", _configList)
	rawset(lua_achievement, "configDict", _configDict)
end

setmetatable(lua_achievement, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_achievement.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_achievement, "configList", nil)
	rawset(lua_achievement, "configDict", nil)
end

return lua_achievement
