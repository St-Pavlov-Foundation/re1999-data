-- chunkname: @modules/configs/excel2json/lua_rogue_collection_backpack.lua

module("modules.configs.excel2json.lua_rogue_collection_backpack", package.seeall)

local lua_rogue_collection_backpack = {}
local fields = {
	id = 1,
	layout = 2,
	initialCollection = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_collection_backpack_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_collection_backpack, "configList", _configList)
	rawset(lua_rogue_collection_backpack, "configDict", _configDict)
end

setmetatable(lua_rogue_collection_backpack, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_collection_backpack.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_collection_backpack, "configList", nil)
	rawset(lua_rogue_collection_backpack, "configDict", nil)
end

return lua_rogue_collection_backpack
