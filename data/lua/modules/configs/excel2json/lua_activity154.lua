-- chunkname: @modules/configs/excel2json/lua_activity154.lua

module("modules.configs.excel2json.lua_activity154", package.seeall)

local lua_activity154 = {}
local fields = {
	puzzleTitle = 4,
	puzzleDesc = 5,
	puzzleId = 3,
	puzzleIcon = 6,
	answerId = 7,
	bonus = 8,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	puzzleTitle = 1,
	puzzleDesc = 2
}
local _configList, _configDict
local configPath = "configs.activity154_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity154, "configList", _configList)
	rawset(lua_activity154, "configDict", _configDict)
end

setmetatable(lua_activity154, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity154.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity154, "configList", nil)
	rawset(lua_activity154, "configDict", nil)
end

return lua_activity154
