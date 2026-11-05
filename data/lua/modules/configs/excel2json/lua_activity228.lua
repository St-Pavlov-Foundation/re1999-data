-- chunkname: @modules/configs/excel2json/lua_activity228.lua

module("modules.configs.excel2json.lua_activity228", package.seeall)

local lua_activity228 = {}
local fields = {
	intensifyGuaranteeCount = 7,
	cost = 5,
	row = 2,
	reward = 4,
	finalReward = 9,
	column = 3,
	effectWeights = 8,
	intensifyRate = 6,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity228_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity228, "configList", _configList)
	rawset(lua_activity228, "configDict", _configDict)
end

setmetatable(lua_activity228, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity228.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity228, "configList", nil)
	rawset(lua_activity228, "configDict", nil)
end

return lua_activity228
