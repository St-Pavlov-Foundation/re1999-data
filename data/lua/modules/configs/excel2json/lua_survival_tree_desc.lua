-- chunkname: @modules/configs/excel2json/lua_survival_tree_desc.lua

module("modules.configs.excel2json.lua_survival_tree_desc", package.seeall)

local lua_survival_tree_desc = {}
local fields = {
	nodeId = 2,
	result = 6,
	id = 1,
	icon = 4,
	condition = 5,
	desc = 3
}
local primaryKey = {
	"id",
	"nodeId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_tree_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_tree_desc, "configList", _configList)
	rawset(lua_survival_tree_desc, "configDict", _configDict)
end

setmetatable(lua_survival_tree_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_tree_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_tree_desc, "configList", nil)
	rawset(lua_survival_tree_desc, "configDict", nil)
end

return lua_survival_tree_desc
