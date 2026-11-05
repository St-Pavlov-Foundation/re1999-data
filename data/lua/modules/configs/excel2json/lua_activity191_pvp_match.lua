-- chunkname: @modules/configs/excel2json/lua_activity191_pvp_match.lua

module("modules.configs.excel2json.lua_activity191_pvp_match", package.seeall)

local lua_activity191_pvp_match = {}
local fields = {
	rewardView = 2,
	attribute = 4,
	autoRewardView = 3,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_pvp_match_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_pvp_match, "configList", _configList)
	rawset(lua_activity191_pvp_match, "configDict", _configDict)
end

setmetatable(lua_activity191_pvp_match, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_pvp_match.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_pvp_match, "configList", nil)
	rawset(lua_activity191_pvp_match, "configDict", nil)
end

return lua_activity191_pvp_match
