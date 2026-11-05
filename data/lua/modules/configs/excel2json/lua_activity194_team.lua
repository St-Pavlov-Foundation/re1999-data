-- chunkname: @modules/configs/excel2json/lua_activity194_team.lua

module("modules.configs.excel2json.lua_activity194_team", package.seeall)

local lua_activity194_team = {}
local fields = {
	teamId = 1,
	name = 4,
	buffId = 2,
	roundActionTime = 5,
	iconOffset = 6,
	picture = 3
}
local primaryKey = {
	"teamId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity194_team_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_team, "configList", _configList)
	rawset(lua_activity194_team, "configDict", _configDict)
end

setmetatable(lua_activity194_team, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_team.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_team, "configList", nil)
	rawset(lua_activity194_team, "configDict", nil)
end

return lua_activity194_team
