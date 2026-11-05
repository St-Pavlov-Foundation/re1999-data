-- chunkname: @modules/configs/excel2json/lua_activity174_turn.lua

module("modules.configs.excel2json.lua_activity174_turn", package.seeall)

local lua_activity174_turn = {}
local fields = {
	groupNum = 7,
	name = 6,
	turn = 2,
	activityId = 1,
	endless = 9,
	shopLevel = 8,
	bag = 5,
	matchCoin = 11,
	point = 10,
	coin = 3,
	winCoin = 4
}
local primaryKey = {
	"activityId",
	"turn"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity174_turn_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_turn, "configList", _configList)
	rawset(lua_activity174_turn, "configDict", _configDict)
end

setmetatable(lua_activity174_turn, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_turn.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_turn, "configList", nil)
	rawset(lua_activity174_turn, "configDict", nil)
end

return lua_activity174_turn
