-- chunkname: @modules/configs/excel2json/lua_auto_fight_role_tool.lua

module("modules.configs.excel2json.lua_auto_fight_role_tool", package.seeall)

local lua_auto_fight_role_tool = {}
local fields = {
	equip = 5,
	exLv = 4,
	equipLv = 6,
	talentStyle = 9,
	destiny = 10,
	roleId = 2,
	talentLv = 8,
	equipExLv = 7,
	id = 1,
	lv = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_fight_role_tool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_fight_role_tool, "configList", _configList)
	rawset(lua_auto_fight_role_tool, "configDict", _configDict)
end

setmetatable(lua_auto_fight_role_tool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_fight_role_tool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_fight_role_tool, "configList", nil)
	rawset(lua_auto_fight_role_tool, "configDict", nil)
end

return lua_auto_fight_role_tool
