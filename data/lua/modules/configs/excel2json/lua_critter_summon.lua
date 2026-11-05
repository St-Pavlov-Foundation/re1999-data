-- chunkname: @modules/configs/excel2json/lua_critter_summon.lua

module("modules.configs.excel2json.lua_critter_summon", package.seeall)

local lua_critter_summon = {}
local fields = {
	cost = 2,
	serverSummon = 3,
	poolId = 1
}
local primaryKey = {
	"poolId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_summon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_summon, "configList", _configList)
	rawset(lua_critter_summon, "configDict", _configDict)
end

setmetatable(lua_critter_summon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_summon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_summon, "configList", nil)
	rawset(lua_critter_summon, "configDict", nil)
end

return lua_critter_summon
