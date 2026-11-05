-- chunkname: @modules/configs/excel2json/lua_challenge_daily_unlock.lua

module("modules.configs.excel2json.lua_challenge_daily_unlock", package.seeall)

local lua_challenge_daily_unlock = {}
local fields = {
	groupId = 1,
	unlock = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.challenge_daily_unlock_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_challenge_daily_unlock, "configList", _configList)
	rawset(lua_challenge_daily_unlock, "configDict", _configDict)
end

setmetatable(lua_challenge_daily_unlock, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_challenge_daily_unlock.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_challenge_daily_unlock, "configList", nil)
	rawset(lua_challenge_daily_unlock, "configDict", nil)
end

return lua_challenge_daily_unlock
