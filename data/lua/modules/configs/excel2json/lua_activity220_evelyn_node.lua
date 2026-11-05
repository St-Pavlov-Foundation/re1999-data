-- chunkname: @modules/configs/excel2json/lua_activity220_evelyn_node.lua

module("modules.configs.excel2json.lua_activity220_evelyn_node", package.seeall)

local lua_activity220_evelyn_node = {}
local fields = {
	stageId = 1,
	name = 5,
	id = 2,
	type = 3,
	outputs = 12,
	desc = 13,
	pos = 7,
	isToolUse = 10,
	inputs = 11,
	subType = 4,
	useTime = 14,
	inputPanelParam = 8,
	icon = 6,
	outPutpanelParam = 9,
	autoInputs = 15
}
local primaryKey = {
	"stageId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity220_evelyn_node_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_evelyn_node, "configList", _configList)
	rawset(lua_activity220_evelyn_node, "configDict", _configDict)
end

setmetatable(lua_activity220_evelyn_node, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_evelyn_node.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_evelyn_node, "configList", nil)
	rawset(lua_activity220_evelyn_node, "configDict", nil)
end

return lua_activity220_evelyn_node
