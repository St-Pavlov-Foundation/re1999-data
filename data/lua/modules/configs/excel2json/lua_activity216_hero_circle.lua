-- chunkname: @modules/configs/excel2json/lua_activity216_hero_circle.lua

module("modules.configs.excel2json.lua_activity216_hero_circle", package.seeall)

local lua_activity216_hero_circle = {}
local fields = {
	id = 1,
	heroId = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity216_hero_circle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity216_hero_circle, "configList", _configList)
	rawset(lua_activity216_hero_circle, "configDict", _configDict)
end

setmetatable(lua_activity216_hero_circle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity216_hero_circle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity216_hero_circle, "configList", nil)
	rawset(lua_activity216_hero_circle, "configDict", nil)
end

return lua_activity216_hero_circle
