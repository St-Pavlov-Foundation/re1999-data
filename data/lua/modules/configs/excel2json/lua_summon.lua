-- chunkname: @modules/configs/excel2json/lua_summon.lua

module("modules.configs.excel2json.lua_summon", package.seeall)

local lua_summon = {}
local fields = {
	id = 1,
	summonId = 3,
	rare = 2,
	luckyBagId = 4
}
local primaryKey = {
	"id",
	"rare"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon, "configList", _configList)
	rawset(lua_summon, "configDict", _configDict)
end

setmetatable(lua_summon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon, "configList", nil)
	rawset(lua_summon, "configDict", nil)
end

return lua_summon
