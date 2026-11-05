-- chunkname: @modules/configs/excel2json/lua_partygame_loading.lua

module("modules.configs.excel2json.lua_partygame_loading", package.seeall)

local lua_partygame_loading = {}
local fields = {
	id = 1,
	des = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 1
}
local _configList, _configDict
local configPath = "configs.partygame_loading_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_loading, "configList", _configList)
	rawset(lua_partygame_loading, "configDict", _configDict)
end

setmetatable(lua_partygame_loading, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_loading.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_loading, "configList", nil)
	rawset(lua_partygame_loading, "configDict", nil)
end

return lua_partygame_loading
