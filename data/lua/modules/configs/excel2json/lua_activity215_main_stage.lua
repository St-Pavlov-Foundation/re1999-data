-- chunkname: @modules/configs/excel2json/lua_activity215_main_stage.lua

module("modules.configs.excel2json.lua_activity215_main_stage", package.seeall)

local lua_activity215_main_stage = {}
local fields = {
	stageId = 2,
	startDayOffset = 3,
	activityId = 1,
	endDayOffset = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity215_main_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity215_main_stage, "configList", _configList)
	rawset(lua_activity215_main_stage, "configDict", _configDict)
end

setmetatable(lua_activity215_main_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity215_main_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity215_main_stage, "configList", nil)
	rawset(lua_activity215_main_stage, "configDict", nil)
end

return lua_activity215_main_stage
