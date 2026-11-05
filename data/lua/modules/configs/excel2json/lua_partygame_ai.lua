-- chunkname: @modules/configs/excel2json/lua_partygame_ai.lua

module("modules.configs.excel2json.lua_partygame_ai", package.seeall)

local lua_partygame_ai = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.partygame_ai_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_ai, "configList", _configList)
	rawset(lua_partygame_ai, "configDict", _configDict)
end

setmetatable(lua_partygame_ai, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_ai.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_ai, "configList", nil)
	rawset(lua_partygame_ai, "configDict", nil)
end

return lua_partygame_ai
