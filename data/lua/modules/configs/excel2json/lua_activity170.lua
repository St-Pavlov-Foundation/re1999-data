-- chunkname: @modules/configs/excel2json/lua_activity170.lua

module("modules.configs.excel2json.lua_activity170", package.seeall)

local lua_activity170 = {}
local fields = {
	summonTimes = 4,
	itemId = 2,
	constId = 6,
	heroExtraDesc = 7,
	initWeight = 3,
	activityId = 1,
	poolId = 5
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity170_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity170, "configList", _configList)
	rawset(lua_activity170, "configDict", _configDict)
end

setmetatable(lua_activity170, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity170.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity170, "configList", nil)
	rawset(lua_activity170, "configDict", nil)
end

return lua_activity170
