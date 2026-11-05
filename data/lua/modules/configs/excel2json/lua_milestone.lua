-- chunkname: @modules/configs/excel2json/lua_milestone.lua

module("modules.configs.excel2json.lua_milestone", package.seeall)

local lua_milestone = {}
local fields = {
	milestoneId = 1,
	isNotPush = 4,
	activityId = 2,
	type = 3
}
local primaryKey = {
	"milestoneId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.milestone_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_milestone, "configList", _configList)
	rawset(lua_milestone, "configDict", _configDict)
end

setmetatable(lua_milestone, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_milestone.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_milestone, "configList", nil)
	rawset(lua_milestone, "configDict", nil)
end

return lua_milestone
