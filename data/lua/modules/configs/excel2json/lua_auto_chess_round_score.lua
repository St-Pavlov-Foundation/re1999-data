-- chunkname: @modules/configs/excel2json/lua_auto_chess_round_score.lua

module("modules.configs.excel2json.lua_auto_chess_round_score", package.seeall)

local lua_auto_chess_round_score = {}
local fields = {
	score = 2,
	rankId = 1,
	mult = 3
}
local primaryKey = {
	"rankId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_round_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_round_score, "configList", _configList)
	rawset(lua_auto_chess_round_score, "configDict", _configDict)
end

setmetatable(lua_auto_chess_round_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_round_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_round_score, "configList", nil)
	rawset(lua_auto_chess_round_score, "configDict", nil)
end

return lua_auto_chess_round_score
