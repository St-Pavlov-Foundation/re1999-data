-- chunkname: @modules/configs/excel2json/lua_trad_npc.lua

module("modules.configs.excel2json.lua_trad_npc", package.seeall)

local lua_trad_npc = {}
local fields = {
	bluffdia = 5,
	name = 2,
	rightdia = 6,
	type = 3,
	id = 1,
	icon = 4,
	wrongdia = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	bluffdia = 2,
	name = 1,
	rightdia = 3,
	wrongdia = 4
}
local _configList, _configDict
local configPath = "configs.trad_npc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trad_npc, "configList", _configList)
	rawset(lua_trad_npc, "configDict", _configDict)
end

setmetatable(lua_trad_npc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trad_npc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trad_npc, "configList", nil)
	rawset(lua_trad_npc, "configDict", nil)
end

return lua_trad_npc
