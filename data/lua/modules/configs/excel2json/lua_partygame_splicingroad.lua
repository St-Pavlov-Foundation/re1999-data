-- chunkname: @modules/configs/excel2json/lua_partygame_splicingroad.lua

module("modules.configs.excel2json.lua_partygame_splicingroad", package.seeall)

local lua_partygame_splicingroad = {}
local fields = {
	id = 1,
	map = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_splicingroad_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_splicingroad, "configList", _configList)
	rawset(lua_partygame_splicingroad, "configDict", _configDict)
end

setmetatable(lua_partygame_splicingroad, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_splicingroad.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_splicingroad, "configList", nil)
	rawset(lua_partygame_splicingroad, "configDict", nil)
end

return lua_partygame_splicingroad
