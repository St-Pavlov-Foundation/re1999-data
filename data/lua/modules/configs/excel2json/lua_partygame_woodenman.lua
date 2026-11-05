-- chunkname: @modules/configs/excel2json/lua_partygame_woodenman.lua

module("modules.configs.excel2json.lua_partygame_woodenman", package.seeall)

local lua_partygame_woodenman = {}
local fields = {
	id = 1,
	group = 2,
	scanTime = 6,
	stopTime = 5,
	prepareTime = 4,
	safeTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_woodenman_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_woodenman, "configList", _configList)
	rawset(lua_partygame_woodenman, "configDict", _configDict)
end

setmetatable(lua_partygame_woodenman, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_woodenman.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_woodenman, "configList", nil)
	rawset(lua_partygame_woodenman, "configDict", nil)
end

return lua_partygame_woodenman
