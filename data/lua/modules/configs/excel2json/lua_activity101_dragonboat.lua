-- chunkname: @modules/configs/excel2json/lua_activity101_dragonboat.lua

module("modules.configs.excel2json.lua_activity101_dragonboat", package.seeall)

local lua_activity101_dragonboat = {}
local fields = {
	desc = 4,
	name = 3,
	dayicon = 5,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity101_dragonboat_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity101_dragonboat, "configList", _configList)
	rawset(lua_activity101_dragonboat, "configDict", _configDict)
end

setmetatable(lua_activity101_dragonboat, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity101_dragonboat.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity101_dragonboat, "configList", nil)
	rawset(lua_activity101_dragonboat, "configDict", nil)
end

return lua_activity101_dragonboat
