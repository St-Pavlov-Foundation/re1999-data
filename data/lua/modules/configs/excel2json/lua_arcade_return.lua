-- chunkname: @modules/configs/excel2json/lua_arcade_return.lua

module("modules.configs.excel2json.lua_arcade_return", package.seeall)

local lua_arcade_return = {}
local fields = {
	refundDesc = 6,
	coinCount = 4,
	preActivityId = 3,
	difficultyId = 2,
	activityId = 1,
	rewardLimit = 5
}
local primaryKey = {
	"activityId",
	"difficultyId"
}
local mlStringKey = {
	refundDesc = 1
}
local _configList, _configDict
local configPath = "configs.arcade_return_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_return, "configList", _configList)
	rawset(lua_arcade_return, "configDict", _configDict)
end

setmetatable(lua_arcade_return, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_return.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_return, "configList", nil)
	rawset(lua_arcade_return, "configDict", nil)
end

return lua_arcade_return
