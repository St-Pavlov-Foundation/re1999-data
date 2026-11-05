-- chunkname: @modules/configs/excel2json/lua_auto_chess_round.lua

module("modules.configs.excel2json.lua_auto_chess_round", package.seeall)

local lua_auto_chess_round = {}
local fields = {
	activityId = 1,
	assess = 5,
	maxdamage = 4,
	starReward = 6,
	round = 2,
	previewCost = 3
}
local primaryKey = {
	"activityId",
	"round"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_round_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_round, "configList", _configList)
	rawset(lua_auto_chess_round, "configDict", _configDict)
end

setmetatable(lua_auto_chess_round, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_round.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_round, "configList", nil)
	rawset(lua_auto_chess_round, "configDict", nil)
end

return lua_auto_chess_round
