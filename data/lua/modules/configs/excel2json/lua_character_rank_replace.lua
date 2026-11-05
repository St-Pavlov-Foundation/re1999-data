-- chunkname: @modules/configs/excel2json/lua_character_rank_replace.lua

module("modules.configs.excel2json.lua_character_rank_replace", package.seeall)

local lua_character_rank_replace = {}
local fields = {
	skill = 3,
	heroType = 5,
	id = 1,
	uniqueSkill_point = 2,
	exSkill = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_rank_replace_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_rank_replace, "configList", _configList)
	rawset(lua_character_rank_replace, "configDict", _configDict)
end

setmetatable(lua_character_rank_replace, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_rank_replace.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_rank_replace, "configList", nil)
	rawset(lua_character_rank_replace, "configDict", nil)
end

return lua_character_rank_replace
