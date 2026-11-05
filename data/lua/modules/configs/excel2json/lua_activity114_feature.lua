-- chunkname: @modules/configs/excel2json/lua_activity114_feature.lua

module("modules.configs.excel2json.lua_activity114_feature", package.seeall)

local lua_activity114_feature = {}
local fields = {
	verifyNum = 5,
	inheritable = 9,
	attributeNum = 6,
	courseEfficiency = 7,
	desc = 4,
	restEfficiency = 8,
	id = 2,
	features = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	features = 1
}
local _configList, _configDict
local configPath = "configs.activity114_feature_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_feature, "configList", _configList)
	rawset(lua_activity114_feature, "configDict", _configDict)
end

setmetatable(lua_activity114_feature, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_feature.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_feature, "configList", nil)
	rawset(lua_activity114_feature, "configDict", nil)
end

return lua_activity114_feature
