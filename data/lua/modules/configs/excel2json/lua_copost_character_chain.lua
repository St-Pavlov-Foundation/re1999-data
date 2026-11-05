-- chunkname: @modules/configs/excel2json/lua_copost_character_chain.lua

module("modules.configs.excel2json.lua_copost_character_chain", package.seeall)

local lua_copost_character_chain = {}
local fields = {
	id = 1,
	fightId = 2,
	stateId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_character_chain_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_character_chain, "configList", _configList)
	rawset(lua_copost_character_chain, "configDict", _configDict)
end

setmetatable(lua_copost_character_chain, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_character_chain.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_character_chain, "configList", nil)
	rawset(lua_copost_character_chain, "configDict", nil)
end

return lua_copost_character_chain
