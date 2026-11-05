-- chunkname: @modules/configs/excel2json/lua_actvity205_stage.lua

module("modules.configs.excel2json.lua_actvity205_stage", package.seeall)

local lua_actvity205_stage = {}
local fields = {
	stageId = 2,
	name = 6,
	times = 5,
	targetDesc = 8,
	ruleTitle = 9,
	ruleDesc = 10,
	desc = 7,
	endTime = 4,
	icon = 11,
	activityId = 1,
	startTime = 3
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {
	ruleTitle = 4,
	name = 1,
	ruleDesc = 5,
	targetDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.actvity205_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity205_stage, "configList", _configList)
	rawset(lua_actvity205_stage, "configDict", _configDict)
end

setmetatable(lua_actvity205_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity205_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity205_stage, "configList", nil)
	rawset(lua_actvity205_stage, "configDict", nil)
end

return lua_actvity205_stage
