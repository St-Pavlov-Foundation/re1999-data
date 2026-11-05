-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_state_show.lua

module("modules.configs.excel2json.lua_arcade_survivor_state_show", package.seeall)

local lua_arcade_survivor_state_show = {}
local fields = {
	id = 1,
	showId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_state_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_state_show, "configList", _configList)
	rawset(lua_arcade_survivor_state_show, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_state_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_state_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_state_show, "configList", nil)
	rawset(lua_arcade_survivor_state_show, "configDict", nil)
end

return lua_arcade_survivor_state_show
