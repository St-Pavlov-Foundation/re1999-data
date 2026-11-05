-- chunkname: @modules/configs/excel2json/lua_party_cloth_summon_pool.lua

module("modules.configs.excel2json.lua_party_cloth_summon_pool", package.seeall)

local lua_party_cloth_summon_pool = {}
local fields = {
	groupInitWeight = 3,
	groupChangeWeight = 4,
	rare = 2,
	poolId = 1
}
local primaryKey = {
	"poolId",
	"rare"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.party_cloth_summon_pool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_cloth_summon_pool, "configList", _configList)
	rawset(lua_party_cloth_summon_pool, "configDict", _configDict)
end

setmetatable(lua_party_cloth_summon_pool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_cloth_summon_pool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_cloth_summon_pool, "configList", nil)
	rawset(lua_party_cloth_summon_pool, "configDict", nil)
end

return lua_party_cloth_summon_pool
