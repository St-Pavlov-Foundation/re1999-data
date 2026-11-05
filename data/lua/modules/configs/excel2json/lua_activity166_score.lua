-- chunkname: @modules/configs/excel2json/lua_activity166_score.lua

module("modules.configs.excel2json.lua_activity166_score", package.seeall)

local lua_activity166_score = {}
local fields = {
	needScore = 3,
	star = 4,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity166_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_score, "configList", _configList)
	rawset(lua_activity166_score, "configDict", _configDict)
end

setmetatable(lua_activity166_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_score, "configList", nil)
	rawset(lua_activity166_score, "configDict", nil)
end

return lua_activity166_score
