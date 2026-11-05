-- chunkname: @modules/configs/excel2json/lua_explore_item_type.lua

module("modules.configs.excel2json.lua_explore_item_type", package.seeall)

local lua_explore_item_type = {}
local fields = {
	isActiveType = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.explore_item_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_item_type, "configList", _configList)
	rawset(lua_explore_item_type, "configDict", _configDict)
end

setmetatable(lua_explore_item_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_item_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_item_type, "configList", nil)
	rawset(lua_explore_item_type, "configDict", nil)
end

return lua_explore_item_type
