-- chunkname: @modules/configs/excel2json/lua_auto_chess_rank.lua

module("modules.configs.excel2json.lua_auto_chess_rank", package.seeall)

local lua_auto_chess_rank = {}
local fields = {
	reward = 8,
	name = 4,
	protection = 5,
	score = 6,
	rankId = 2,
	isShow = 9,
	loseStreak = 11,
	maxRound = 10,
	icon = 3,
	activityId = 1,
	round2Score = 7
}
local primaryKey = {
	"activityId",
	"rankId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.auto_chess_rank_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_rank, "configList", _configList)
	rawset(lua_auto_chess_rank, "configDict", _configDict)
end

setmetatable(lua_auto_chess_rank, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_rank.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_rank, "configList", nil)
	rawset(lua_auto_chess_rank, "configDict", nil)
end

return lua_auto_chess_rank
