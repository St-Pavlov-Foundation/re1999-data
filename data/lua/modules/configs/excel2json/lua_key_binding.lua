-- chunkname: @modules/configs/excel2json/lua_key_binding.lua

module("modules.configs.excel2json.lua_key_binding", package.seeall)

local lua_key_binding = {}
local fields = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
local primaryKey = {
	"hud",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.key_binding_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_key_binding, "configList", _configList)
	rawset(lua_key_binding, "configDict", _configDict)
end

setmetatable(lua_key_binding, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_key_binding.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_key_binding, "configList", nil)
	rawset(lua_key_binding, "configDict", nil)
end

return lua_key_binding
