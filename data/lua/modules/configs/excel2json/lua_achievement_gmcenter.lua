-- chunkname: @modules/configs/excel2json/lua_achievement_gmcenter.lua

module("modules.configs.excel2json.lua_achievement_gmcenter", package.seeall)

local lua_achievement_gmcenter = {}
local fields = {
	id = 1,
	achievementId = 3,
	category = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.achievement_gmcenter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_achievement_gmcenter, "configList", _configList)
	rawset(lua_achievement_gmcenter, "configDict", _configDict)
end

setmetatable(lua_achievement_gmcenter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_achievement_gmcenter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_achievement_gmcenter, "configList", nil)
	rawset(lua_achievement_gmcenter, "configDict", nil)
end

return lua_achievement_gmcenter
