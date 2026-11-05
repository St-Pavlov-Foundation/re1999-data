-- chunkname: @modules/configs/excel2json/lua_party_cloth_summon.lua

module("modules.configs.excel2json.lua_party_cloth_summon", package.seeall)

local lua_party_cloth_summon = {}
local fields = {
	cost = 4,
	changeWeight = 3,
	initWeight = 2,
	activityId = 5,
	poolId = 1
}
local primaryKey = {
	"poolId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.party_cloth_summon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_cloth_summon, "configList", _configList)
	rawset(lua_party_cloth_summon, "configDict", _configDict)
end

setmetatable(lua_party_cloth_summon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_cloth_summon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_cloth_summon, "configList", nil)
	rawset(lua_party_cloth_summon, "configDict", nil)
end

return lua_party_cloth_summon
