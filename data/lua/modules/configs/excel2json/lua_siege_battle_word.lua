-- chunkname: @modules/configs/excel2json/lua_siege_battle_word.lua

module("modules.configs.excel2json.lua_siege_battle_word", package.seeall)

local lua_siege_battle_word = {}
local fields = {
	id = 1,
	sign = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.siege_battle_word_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_siege_battle_word, "configList", _configList)
	rawset(lua_siege_battle_word, "configDict", _configDict)
end

setmetatable(lua_siege_battle_word, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_siege_battle_word.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_siege_battle_word, "configList", nil)
	rawset(lua_siege_battle_word, "configDict", nil)
end

return lua_siege_battle_word
