-- chunkname: @modules/configs/excel2json/lua_roleactivity_enter.lua

module("modules.configs.excel2json.lua_roleactivity_enter", package.seeall)

local lua_roleactivity_enter = {}
local fields = {
	storyGroupId = 2,
	activityId = 1,
	episodeGroupId = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.roleactivity_enter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_roleactivity_enter, "configList", _configList)
	rawset(lua_roleactivity_enter, "configDict", _configDict)
end

setmetatable(lua_roleactivity_enter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_roleactivity_enter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_roleactivity_enter, "configList", nil)
	rawset(lua_roleactivity_enter, "configDict", nil)
end

return lua_roleactivity_enter
