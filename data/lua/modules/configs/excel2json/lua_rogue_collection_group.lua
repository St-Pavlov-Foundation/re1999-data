-- chunkname: @modules/configs/excel2json/lua_rogue_collection_group.lua

module("modules.configs.excel2json.lua_rogue_collection_group", package.seeall)

local lua_rogue_collection_group = {}
local fields = {
	id = 1,
	num = 2,
	dropGroupType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	dropGroupType = 1
}
local _configList, _configDict
local configPath = "configs.rogue_collection_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_collection_group, "configList", _configList)
	rawset(lua_rogue_collection_group, "configDict", _configDict)
end

setmetatable(lua_rogue_collection_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_collection_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_collection_group, "configList", nil)
	rawset(lua_rogue_collection_group, "configDict", nil)
end

return lua_rogue_collection_group
