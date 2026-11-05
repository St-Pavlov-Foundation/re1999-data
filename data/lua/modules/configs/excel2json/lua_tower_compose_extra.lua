-- chunkname: @modules/configs/excel2json/lua_tower_compose_extra.lua

module("modules.configs.excel2json.lua_tower_compose_extra", package.seeall)

local lua_tower_compose_extra = {}
local fields = {
	themeId = 2,
	id = 1,
	bossPointBase = 3
}
local primaryKey = {
	"id",
	"themeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_compose_extra_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_extra, "configList", _configList)
	rawset(lua_tower_compose_extra, "configDict", _configDict)
end

setmetatable(lua_tower_compose_extra, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_extra.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_extra, "configList", nil)
	rawset(lua_tower_compose_extra, "configDict", nil)
end

return lua_tower_compose_extra
