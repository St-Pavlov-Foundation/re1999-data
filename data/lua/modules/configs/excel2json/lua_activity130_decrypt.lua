-- chunkname: @modules/configs/excel2json/lua_activity130_decrypt.lua

module("modules.configs.excel2json.lua_activity130_decrypt", package.seeall)

local lua_activity130_decrypt = {}
local fields = {
	puzzleType = 6,
	operGroupId = 4,
	puzzleMapId = 3,
	maxStep = 9,
	extStarDesc = 13,
	errorTip = 10,
	maxOper = 8,
	extStarCondition = 12,
	puzzleTip = 11,
	answer = 7,
	puzzleTxt = 5,
	activityId = 1,
	puzzleId = 2
}
local primaryKey = {
	"activityId",
	"puzzleId"
}
local mlStringKey = {
	extStarDesc = 2,
	puzzleTxt = 1
}
local _configList, _configDict
local configPath = "configs.activity130_decrypt_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity130_decrypt, "configList", _configList)
	rawset(lua_activity130_decrypt, "configDict", _configDict)
end

setmetatable(lua_activity130_decrypt, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity130_decrypt.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity130_decrypt, "configList", nil)
	rawset(lua_activity130_decrypt, "configDict", nil)
end

return lua_activity130_decrypt
