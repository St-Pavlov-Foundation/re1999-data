-- chunkname: @modules/configs/excel2json/lua_survival_shop_type.lua

module("modules.configs.excel2json.lua_survival_shop_type", package.seeall)

local lua_survival_shop_type = {}
local fields = {
	id = 1,
	name = 2,
	tabIcon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_shop_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shop_type, "configList", _configList)
	rawset(lua_survival_shop_type, "configDict", _configDict)
end

setmetatable(lua_survival_shop_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shop_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shop_type, "configList", nil)
	rawset(lua_survival_shop_type, "configDict", nil)
end

return lua_survival_shop_type
