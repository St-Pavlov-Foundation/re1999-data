-- chunkname: @modules/configs/excel2json/lua_challenge_badge.lua

module("modules.configs.excel2json.lua_challenge_badge", package.seeall)

local lua_challenge_badge = {}
local fields = {
	rule = 3,
	unlockSupport = 5,
	num = 2,
	activityId = 1,
	decs = 4
}
local primaryKey = {
	"activityId",
	"num"
}
local mlStringKey = {
	decs = 1
}
local _configList, _configDict
local configPath = "configs.challenge_badge_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_challenge_badge, "configList", _configList)
	rawset(lua_challenge_badge, "configDict", _configDict)
end

setmetatable(lua_challenge_badge, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_challenge_badge.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_challenge_badge, "configList", nil)
	rawset(lua_challenge_badge, "configDict", nil)
end

return lua_challenge_badge
