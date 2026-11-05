-- chunkname: @modules/configs/excel2json/lua_activity165_ending.lua

module("modules.configs.excel2json.lua_activity165_ending", package.seeall)

local lua_activity165_ending = {}
local fields = {
	text = 5,
	level = 6,
	pic = 7,
	endingText = 4,
	endingId = 1,
	finalStepId = 3,
	belongStoryId = 2
}
local primaryKey = {
	"endingId"
}
local mlStringKey = {
	text = 2,
	endingText = 1
}
local _configList, _configDict
local configPath = "configs.activity165_ending_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity165_ending, "configList", _configList)
	rawset(lua_activity165_ending, "configDict", _configDict)
end

setmetatable(lua_activity165_ending, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity165_ending.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity165_ending, "configList", nil)
	rawset(lua_activity165_ending, "configDict", nil)
end

return lua_activity165_ending
