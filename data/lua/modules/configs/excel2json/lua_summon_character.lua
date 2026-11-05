-- chunkname: @modules/configs/excel2json/lua_summon_character.lua

module("modules.configs.excel2json.lua_summon_character", package.seeall)

local lua_summon_character = {}
local fields = {
	id = 1,
	heroId = 2,
	location = 4,
	skinId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_character, "configList", _configList)
	rawset(lua_summon_character, "configDict", _configDict)
end

setmetatable(lua_summon_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_character, "configList", nil)
	rawset(lua_summon_character, "configDict", nil)
end

return lua_summon_character
