-- chunkname: @modules/configs/excel2json/lua_activity238.lua

module("modules.configs.excel2json.lua_activity238", package.seeall)

local lua_activity238 = {}
local fields = {
	option3 = 8,
	option1 = 6,
	correctOption = 9,
	questionPictuer = 5,
	answer = 10,
	title = 13,
	desc = 3,
	option2 = 7,
	questionMask = 4,
	id = 2,
	bubbleIds = 12,
	activityId = 1,
	bonus = 11
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	option3 = 4,
	answer = 5,
	option2 = 3,
	option1 = 2,
	title = 6,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity238_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity238, "configList", _configList)
	rawset(lua_activity238, "configDict", _configDict)
end

setmetatable(lua_activity238, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity238.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity238, "configList", nil)
	rawset(lua_activity238, "configDict", nil)
end

return lua_activity238
