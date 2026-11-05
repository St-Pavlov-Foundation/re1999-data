-- chunkname: @modules/configs/excel2json/lua_partygame_snatchterritory.lua

module("modules.configs.excel2json.lua_partygame_snatchterritory", package.seeall)

local lua_partygame_snatchterritory = {}
local fields = {
	playerNum = 2,
	numMax = 3,
	id = 1,
	interval = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_snatchterritory_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_snatchterritory, "configList", _configList)
	rawset(lua_partygame_snatchterritory, "configDict", _configDict)
end

setmetatable(lua_partygame_snatchterritory, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_snatchterritory.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_snatchterritory, "configList", nil)
	rawset(lua_partygame_snatchterritory, "configDict", nil)
end

return lua_partygame_snatchterritory
