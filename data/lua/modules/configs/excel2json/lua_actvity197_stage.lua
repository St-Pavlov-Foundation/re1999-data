-- chunkname: @modules/configs/excel2json/lua_actvity197_stage.lua

module("modules.configs.excel2json.lua_actvity197_stage", package.seeall)

local lua_actvity197_stage = {}
local fields = {
	stageId = 2,
	globalTaskId = 6,
	globalTaskActivityId = 5,
	endTime = 4,
	activityId = 1,
	startTime = 3
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.actvity197_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity197_stage, "configList", _configList)
	rawset(lua_actvity197_stage, "configDict", _configDict)
end

setmetatable(lua_actvity197_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity197_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity197_stage, "configList", nil)
	rawset(lua_actvity197_stage, "configDict", nil)
end

return lua_actvity197_stage
