-- chunkname: @modules/configs/excel2json/lua_character_battle_tag.lua

module("modules.configs.excel2json.lua_character_battle_tag", package.seeall)

local lua_character_battle_tag = {}
local fields = {
	id = 1,
	typeid = 3,
	tagName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tagName = 1
}
local _configList, _configDict
local configPath = "configs.character_battle_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_battle_tag, "configList", _configList)
	rawset(lua_character_battle_tag, "configDict", _configDict)
end

setmetatable(lua_character_battle_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_battle_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_battle_tag, "configList", nil)
	rawset(lua_character_battle_tag, "configDict", nil)
end

return lua_character_battle_tag
