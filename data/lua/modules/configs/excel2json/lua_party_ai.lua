-- chunkname: @modules/configs/excel2json/lua_party_ai.lua

module("modules.configs.excel2json.lua_party_ai", package.seeall)

local lua_party_ai = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.party_ai_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_ai, "configList", _configList)
	rawset(lua_party_ai, "configDict", _configDict)
end

setmetatable(lua_party_ai, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_ai.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_ai, "configList", nil)
	rawset(lua_party_ai, "configDict", nil)
end

return lua_party_ai
