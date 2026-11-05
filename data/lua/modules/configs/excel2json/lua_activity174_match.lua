-- chunkname: @modules/configs/excel2json/lua_activity174_match.lua

module("modules.configs.excel2json.lua_activity174_match", package.seeall)

local lua_activity174_match = {}
local fields = {
	score = 4,
	rank = 2,
	count = 3,
	matchRule = 5,
	robotRate = 9,
	matchRuleLimit = 6,
	lostValue = 8,
	activityId = 1,
	winValue = 7
}
local primaryKey = {
	"activityId",
	"rank",
	"count"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_match_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_match, "configList", _configList)
	rawset(lua_activity174_match, "configDict", _configDict)
end

setmetatable(lua_activity174_match, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_match.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_match, "configList", nil)
	rawset(lua_activity174_match, "configDict", nil)
end

return lua_activity174_match
