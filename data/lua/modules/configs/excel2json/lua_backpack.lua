-- chunkname: @modules/configs/excel2json/lua_backpack.lua

module("modules.configs.excel2json.lua_backpack", package.seeall)

local lua_backpack = {}
local fields = {
	includecurrency = 5,
	name = 2,
	includeitem = 4,
	subname = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.backpack_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_backpack, "configList", _configList)
	rawset(lua_backpack, "configDict", _configDict)
end

setmetatable(lua_backpack, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_backpack.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_backpack, "configList", nil)
	rawset(lua_backpack, "configDict", nil)
end

return lua_backpack
