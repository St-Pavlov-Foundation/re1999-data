-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_behavior.lua

module("modules.configs.excel2json.lua_arcade_survivor_behavior", package.seeall)

local lua_arcade_survivor_behavior = {}
local fields = {
	params = 4,
	treeId = 1,
	nodeId = 2,
	nodeType = 3,
	childIds = 5
}
local primaryKey = {
	"treeId",
	"nodeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_behavior_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_behavior, "configList", _configList)
	rawset(lua_arcade_survivor_behavior, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_behavior, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_behavior.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_behavior, "configList", nil)
	rawset(lua_arcade_survivor_behavior, "configDict", nil)
end

return lua_arcade_survivor_behavior
