-- chunkname: @modules/configs/excel2json/lua_activity144_round.lua

module("modules.configs.excel2json.lua_activity144_round", package.seeall)

local lua_activity144_round = {}
local fields = {
	isPass = 4,
	keepMaterialRate = 6,
	round = 3,
	name = 7,
	actionPoint = 5,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId",
	"round"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity144_round_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_round, "configList", _configList)
	rawset(lua_activity144_round, "configDict", _configDict)
end

setmetatable(lua_activity144_round, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_round.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_round, "configList", nil)
	rawset(lua_activity144_round, "configDict", nil)
end

return lua_activity144_round
