-- chunkname: @modules/configs/excel2json/lua_store_bundle.lua

module("modules.configs.excel2json.lua_store_bundle", package.seeall)

local lua_store_bundle = {}
local fields = {
	fatherGoods = 1,
	sonGoods = 2
}
local primaryKey = {
	"fatherGoods"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.store_bundle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_bundle, "configList", _configList)
	rawset(lua_store_bundle, "configDict", _configDict)
end

setmetatable(lua_store_bundle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_bundle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_bundle, "configList", nil)
	rawset(lua_store_bundle, "configDict", nil)
end

return lua_store_bundle
