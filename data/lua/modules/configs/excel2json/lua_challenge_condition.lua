-- chunkname: @modules/configs/excel2json/lua_challenge_condition.lua

module("modules.configs.excel2json.lua_challenge_condition", package.seeall)

local lua_challenge_condition = {}
local fields = {
	decs1 = 4,
	decs2 = 6,
	id = 1,
	type = 2,
	value = 3,
	rule = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	decs2 = 2,
	decs1 = 1
}
local _configList, _configDict
local configPath = "configs.challenge_condition_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_challenge_condition, "configList", _configList)
	rawset(lua_challenge_condition, "configDict", _configDict)
end

setmetatable(lua_challenge_condition, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_challenge_condition.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_challenge_condition, "configList", nil)
	rawset(lua_challenge_condition, "configDict", nil)
end

return lua_challenge_condition
