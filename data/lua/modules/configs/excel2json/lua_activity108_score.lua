-- chunkname: @modules/configs/excel2json/lua_activity108_score.lua

module("modules.configs.excel2json.lua_activity108_score", package.seeall)

local lua_activity108_score = {}
local fields = {
	grade = 2,
	id = 1,
	maxScore = 4,
	minScore = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity108_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_score, "configList", _configList)
	rawset(lua_activity108_score, "configDict", _configDict)
end

setmetatable(lua_activity108_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_score, "configList", nil)
	rawset(lua_activity108_score, "configDict", nil)
end

return lua_activity108_score
