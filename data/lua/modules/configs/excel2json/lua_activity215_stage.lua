-- chunkname: @modules/configs/excel2json/lua_activity215_stage.lua

module("modules.configs.excel2json.lua_activity215_stage", package.seeall)

local lua_activity215_stage = {}
local fields = {
	stageId = 2,
	globalTaskActivityId = 3,
	activityId = 1,
	globalTaskId = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity215_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity215_stage, "configList", _configList)
	rawset(lua_activity215_stage, "configDict", _configDict)
end

setmetatable(lua_activity215_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity215_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity215_stage, "configList", nil)
	rawset(lua_activity215_stage, "configDict", nil)
end

return lua_activity215_stage
