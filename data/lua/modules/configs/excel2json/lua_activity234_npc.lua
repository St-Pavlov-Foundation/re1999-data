-- chunkname: @modules/configs/excel2json/lua_activity234_npc.lua

module("modules.configs.excel2json.lua_activity234_npc", package.seeall)

local lua_activity234_npc = {}
local fields = {
	id = 1,
	name = 2,
	icon = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity234_npc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity234_npc, "configList", _configList)
	rawset(lua_activity234_npc, "configDict", _configDict)
end

setmetatable(lua_activity234_npc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity234_npc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity234_npc, "configList", nil)
	rawset(lua_activity234_npc, "configDict", nil)
end

return lua_activity234_npc
