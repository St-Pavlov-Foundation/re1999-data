-- chunkname: @modules/configs/excel2json/lua_activity104_advanced_new.lua

module("modules.configs.excel2json.lua_activity104_advanced_new", package.seeall)

local lua_activity104_advanced_new = {}
local fields = {
	activityId = 1,
	retailEpisodeId = 2
}
local primaryKey = {
	"activityId",
	"retailEpisodeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity104_advanced_new_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_advanced_new, "configList", _configList)
	rawset(lua_activity104_advanced_new, "configDict", _configDict)
end

setmetatable(lua_activity104_advanced_new, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_advanced_new.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_advanced_new, "configList", nil)
	rawset(lua_activity104_advanced_new, "configDict", nil)
end

return lua_activity104_advanced_new
