-- chunkname: @modules/configs/excel2json/lua_activity114_test.lua

module("modules.configs.excel2json.lua_activity114_test", package.seeall)

local lua_activity114_test = {}
local fields = {
	score = 8,
	topic = 4,
	result = 9,
	testId = 3,
	choice2 = 6,
	choice1 = 5,
	id = 2,
	activityId = 1,
	choice3 = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	topic = 1,
	choice2 = 3,
	choice3 = 4,
	choice1 = 2
}
local _configList, _configDict
local configPath = "configs.activity114_test_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_test, "configList", _configList)
	rawset(lua_activity114_test, "configDict", _configDict)
end

setmetatable(lua_activity114_test, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_test.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_test, "configList", nil)
	rawset(lua_activity114_test, "configDict", nil)
end

return lua_activity114_test
