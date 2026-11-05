-- chunkname: @modules/configs/excel2json/lua_editor_role_sources.lua

module("modules.configs.excel2json.lua_editor_role_sources", package.seeall)

local lua_editor_role_sources = {}
local fields = {
	id = 1,
	name = 3,
	exSkill = 4,
	skinId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.editor_role_sources_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_editor_role_sources, "configList", _configList)
	rawset(lua_editor_role_sources, "configDict", _configDict)
end

setmetatable(lua_editor_role_sources, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_editor_role_sources.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_editor_role_sources, "configList", nil)
	rawset(lua_editor_role_sources, "configDict", nil)
end

return lua_editor_role_sources
