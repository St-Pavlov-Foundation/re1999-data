-- chunkname: @modules/configs/excel2json/lua_match3_chain_multiplier.lua

module("modules.configs.excel2json.lua_match3_chain_multiplier", package.seeall)

local lua_match3_chain_multiplier = {}
local fields = {
	chainMin = 2,
	multiplier = 4,
	chainMax = 3,
	id = 1,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.match3_chain_multiplier_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_chain_multiplier, "configList", _configList)
	rawset(lua_match3_chain_multiplier, "configDict", _configDict)
end

setmetatable(lua_match3_chain_multiplier, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_chain_multiplier.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_chain_multiplier, "configList", nil)
	rawset(lua_match3_chain_multiplier, "configDict", nil)
end

return lua_match3_chain_multiplier
