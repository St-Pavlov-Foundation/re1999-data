-- chunkname: @modules/configs/excel2json/lua_rogue_collection_drop.lua

module("modules.configs.excel2json.lua_rogue_collection_drop", package.seeall)

local lua_rogue_collection_drop = {}
local fields = {
	groupId = 2,
	id = 1,
	weights = 3
}
local primaryKey = {
	"id",
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_collection_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_collection_drop, "configList", _configList)
	rawset(lua_rogue_collection_drop, "configDict", _configDict)
end

setmetatable(lua_rogue_collection_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_collection_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_collection_drop, "configList", nil)
	rawset(lua_rogue_collection_drop, "configDict", nil)
end

return lua_rogue_collection_drop
