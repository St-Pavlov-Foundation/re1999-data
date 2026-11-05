-- chunkname: @modules/configs/excel2json/lua_activity123_stage.lua

module("modules.configs.excel2json.lua_activity123_stage", package.seeall)

local lua_activity123_stage = {}
local fields = {
	recommendSchool = 13,
	name = 4,
	preCondition = 3,
	finalScale = 9,
	mainEquip = 10,
	initScale = 7,
	initPos = 6,
	stageCondition = 12,
	res = 5,
	finalPos = 8,
	stage = 2,
	activityId = 1,
	recommend = 11
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity123_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_stage, "configList", _configList)
	rawset(lua_activity123_stage, "configDict", _configDict)
end

setmetatable(lua_activity123_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_stage, "configList", nil)
	rawset(lua_activity123_stage, "configDict", nil)
end

return lua_activity123_stage
