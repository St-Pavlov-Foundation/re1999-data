-- chunkname: @modules/configs/excel2json/lua_tower_compose_aura.lua

module("modules.configs.excel2json.lua_tower_compose_aura", package.seeall)

local lua_tower_compose_aura = {}
local fields = {
	effects = 5,
	name = 4,
	themeId = 2,
	type = 8,
	id = 1,
	image = 3,
	icon = 6,
	desc = 7
}
local primaryKey = {
	"id",
	"themeId"
}
local mlStringKey = {
	type = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.tower_compose_aura_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_aura, "configList", _configList)
	rawset(lua_tower_compose_aura, "configDict", _configDict)
end

setmetatable(lua_tower_compose_aura, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_aura.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_aura, "configList", nil)
	rawset(lua_tower_compose_aura, "configDict", nil)
end

return lua_tower_compose_aura
