-- chunkname: @modules/configs/excel2json/lua_copost_npc_text.lua

module("modules.configs.excel2json.lua_copost_npc_text", package.seeall)

local lua_copost_npc_text = {}
local fields = {
	text = 2,
	id = 1,
	engtext = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.copost_npc_text_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_npc_text, "configList", _configList)
	rawset(lua_copost_npc_text, "configDict", _configDict)
end

setmetatable(lua_copost_npc_text, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_npc_text.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_npc_text, "configList", nil)
	rawset(lua_copost_npc_text, "configDict", nil)
end

return lua_copost_npc_text
