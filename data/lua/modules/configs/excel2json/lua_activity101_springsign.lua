-- chunkname: @modules/configs/excel2json/lua_activity101_springsign.lua

module("modules.configs.excel2json.lua_activity101_springsign", package.seeall)

local lua_activity101_springsign = {}
local fields = {
	goodDesc = 6,
	name = 3,
	simpleDesc = 4,
	detailDesc = 5,
	badDesc = 7,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	goodDesc = 4,
	name = 1,
	simpleDesc = 2,
	detailDesc = 3,
	badDesc = 5
}
local _configList, _configDict
local configPath = "configs.activity101_springsign_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity101_springsign, "configList", _configList)
	rawset(lua_activity101_springsign, "configDict", _configDict)
end

setmetatable(lua_activity101_springsign, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity101_springsign.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity101_springsign, "configList", nil)
	rawset(lua_activity101_springsign, "configDict", nil)
end

return lua_activity101_springsign
