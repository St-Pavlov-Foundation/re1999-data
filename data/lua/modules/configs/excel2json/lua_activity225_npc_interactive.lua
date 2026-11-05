-- chunkname: @modules/configs/excel2json/lua_activity225_npc_interactive.lua

module("modules.configs.excel2json.lua_activity225_npc_interactive", package.seeall)

local lua_activity225_npc_interactive = {}
local fields = {
	interactiveTxt = 3,
	interactiveType = 2,
	interactiveId = 1,
	interactivePng = 4
}
local primaryKey = {
	"interactiveId"
}
local mlStringKey = {
	interactiveTxt = 1
}
local _configList, _configDict
local configPath = "configs.activity225_npc_interactive_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_npc_interactive, "configList", _configList)
	rawset(lua_activity225_npc_interactive, "configDict", _configDict)
end

setmetatable(lua_activity225_npc_interactive, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_npc_interactive.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_npc_interactive, "configList", nil)
	rawset(lua_activity225_npc_interactive, "configDict", nil)
end

return lua_activity225_npc_interactive
