-- chunkname: @modules/configs/excel2json/lua_activity178_marbles.lua

module("modules.configs.excel2json.lua_activity178_marbles", package.seeall)

local lua_activity178_marbles = {}
local fields = {
	detectTime = 9,
	name = 3,
	radius = 6,
	elasticity = 7,
	effectTime2 = 11,
	limit = 12,
	effectTime = 10,
	desc = 4,
	id = 2,
	icon = 5,
	activityId = 1,
	velocity = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity178_marbles_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_marbles, "configList", _configList)
	rawset(lua_activity178_marbles, "configDict", _configDict)
end

setmetatable(lua_activity178_marbles, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_marbles.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_marbles, "configList", nil)
	rawset(lua_activity178_marbles, "configDict", nil)
end

return lua_activity178_marbles
