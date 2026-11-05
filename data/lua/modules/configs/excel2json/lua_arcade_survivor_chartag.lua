-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_chartag.lua

module("modules.configs.excel2json.lua_arcade_survivor_chartag", package.seeall)

local lua_arcade_survivor_chartag = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_chartag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_chartag, "configList", _configList)
	rawset(lua_arcade_survivor_chartag, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_chartag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_chartag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_chartag, "configList", nil)
	rawset(lua_arcade_survivor_chartag, "configDict", nil)
end

return lua_arcade_survivor_chartag
