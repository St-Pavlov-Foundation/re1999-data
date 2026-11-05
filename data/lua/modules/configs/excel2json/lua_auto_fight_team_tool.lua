-- chunkname: @modules/configs/excel2json/lua_auto_fight_team_tool.lua

module("modules.configs.excel2json.lua_auto_fight_team_tool", package.seeall)

local lua_auto_fight_team_tool = {}
local fields = {
	position3 = 5,
	name = 2,
	position2 = 4,
	id = 1,
	position1 = 3,
	position4 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_fight_team_tool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_fight_team_tool, "configList", _configList)
	rawset(lua_auto_fight_team_tool, "configDict", _configDict)
end

setmetatable(lua_auto_fight_team_tool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_fight_team_tool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_fight_team_tool, "configList", nil)
	rawset(lua_auto_fight_team_tool, "configDict", nil)
end

return lua_auto_fight_team_tool
