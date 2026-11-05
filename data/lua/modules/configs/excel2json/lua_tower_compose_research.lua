-- chunkname: @modules/configs/excel2json/lua_tower_compose_research.lua

module("modules.configs.excel2json.lua_tower_compose_research", package.seeall)

local lua_tower_compose_research = {}
local fields = {
	themeId = 2,
	name = 4,
	exLevel = 8,
	additionRule = 7,
	id = 1,
	req = 3,
	icon = 6,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	icon = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.tower_compose_research_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_research, "configList", _configList)
	rawset(lua_tower_compose_research, "configDict", _configDict)
end

setmetatable(lua_tower_compose_research, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_research.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_research, "configList", nil)
	rawset(lua_tower_compose_research, "configDict", nil)
end

return lua_tower_compose_research
