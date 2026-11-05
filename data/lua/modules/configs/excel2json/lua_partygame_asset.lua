-- chunkname: @modules/configs/excel2json/lua_partygame_asset.lua

module("modules.configs.excel2json.lua_partygame_asset", package.seeall)

local lua_partygame_asset = {}
local fields = {
	id = 1,
	filePath = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_asset_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_asset, "configList", _configList)
	rawset(lua_partygame_asset, "configDict", _configDict)
end

setmetatable(lua_partygame_asset, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_asset.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_asset, "configList", nil)
	rawset(lua_partygame_asset, "configDict", nil)
end

return lua_partygame_asset
