-- chunkname: @modules/configs/excel2json/lua_copost_npc.lua

module("modules.configs.excel2json.lua_copost_npc", package.seeall)

local lua_copost_npc = {}
local fields = {
	weight = 4,
	time = 5,
	id = 1,
	condition = 3,
	textId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_npc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_npc, "configList", _configList)
	rawset(lua_copost_npc, "configDict", _configDict)
end

setmetatable(lua_copost_npc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_npc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_npc, "configList", nil)
	rawset(lua_copost_npc, "configDict", nil)
end

return lua_copost_npc
