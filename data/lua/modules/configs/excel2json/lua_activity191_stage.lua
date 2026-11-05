-- chunkname: @modules/configs/excel2json/lua_activity191_stage.lua

module("modules.configs.excel2json.lua_activity191_stage", package.seeall)

local lua_activity191_stage = {}
local fields = {
	score = 7,
	name = 6,
	rule = 5,
	nextId = 3,
	id = 2,
	initStage = 4,
	activityId = 1,
	coin = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_stage, "configList", _configList)
	rawset(lua_activity191_stage, "configDict", _configDict)
end

setmetatable(lua_activity191_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_stage, "configList", nil)
	rawset(lua_activity191_stage, "configDict", nil)
end

return lua_activity191_stage
