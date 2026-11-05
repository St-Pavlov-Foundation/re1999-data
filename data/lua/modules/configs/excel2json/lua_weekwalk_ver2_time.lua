-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_time.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_time", package.seeall)

local lua_weekwalk_ver2_time = {}
local fields = {
	ruleFront = 5,
	ruleRear = 6,
	issueId = 2,
	ruleIcon = 4,
	optionalSkills = 3,
	timeId = 1
}
local primaryKey = {
	"timeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_ver2_time_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_ver2_time, "configList", _configList)
	rawset(lua_weekwalk_ver2_time, "configDict", _configDict)
end

setmetatable(lua_weekwalk_ver2_time, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_ver2_time.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_ver2_time, "configList", nil)
	rawset(lua_weekwalk_ver2_time, "configDict", nil)
end

return lua_weekwalk_ver2_time
