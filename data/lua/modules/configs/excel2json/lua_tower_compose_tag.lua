-- chunkname: @modules/configs/excel2json/lua_tower_compose_tag.lua

module("modules.configs.excel2json.lua_tower_compose_tag", package.seeall)

local lua_tower_compose_tag = {}
local fields = {
	effects = 6,
	name = 3,
	themeId = 2,
	id = 1,
	icon = 4,
	desc = 5
}
local primaryKey = {
	"id",
	"themeId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_compose_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_tag, "configList", _configList)
	rawset(lua_tower_compose_tag, "configDict", _configDict)
end

setmetatable(lua_tower_compose_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_tag, "configList", nil)
	rawset(lua_tower_compose_tag, "configDict", nil)
end

return lua_tower_compose_tag
