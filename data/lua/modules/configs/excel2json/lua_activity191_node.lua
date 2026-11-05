-- chunkname: @modules/configs/excel2json/lua_activity191_node.lua

module("modules.configs.excel2json.lua_activity191_node", package.seeall)

local lua_activity191_node = {}
local fields = {
	selectNum = 4,
	ruleId = 1,
	random = 3,
	node = 2,
	desc = 5
}
local primaryKey = {
	"ruleId",
	"node"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity191_node_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_node, "configList", _configList)
	rawset(lua_activity191_node, "configDict", _configDict)
end

setmetatable(lua_activity191_node, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_node.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_node, "configList", nil)
	rawset(lua_activity191_node, "configDict", nil)
end

return lua_activity191_node
