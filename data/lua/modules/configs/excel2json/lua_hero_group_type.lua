-- chunkname: @modules/configs/excel2json/lua_hero_group_type.lua

module("modules.configs.excel2json.lua_hero_group_type", package.seeall)

local lua_hero_group_type = {}
local fields = {
	saveGroup = 4,
	name = 2,
	chapterIds = 3,
	id = 1,
	changeForbiddenEpisode = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_group_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_group_type, "configList", _configList)
	rawset(lua_hero_group_type, "configDict", _configDict)
end

setmetatable(lua_hero_group_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_group_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_group_type, "configList", nil)
	rawset(lua_hero_group_type, "configDict", nil)
end

return lua_hero_group_type
