-- chunkname: @modules/configs/excel2json/lua_activity188_ai.lua

module("modules.configs.excel2json.lua_activity188_ai", package.seeall)

local lua_activity188_ai = {}
local fields = {
	pairRate = 5,
	pairRound = 4,
	reverseTime = 3,
	difficult = 2,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"difficult"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity188_ai_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_ai, "configList", _configList)
	rawset(lua_activity188_ai, "configDict", _configDict)
end

setmetatable(lua_activity188_ai, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_ai.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_ai, "configList", nil)
	rawset(lua_activity188_ai, "configDict", nil)
end

return lua_activity188_ai
