-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_dialog_group.lua

module("modules.configs.excel2json.lua_arcade_survivor_dialog_group", package.seeall)

local lua_arcade_survivor_dialog_group = {}
local fields = {
	groupId = 1,
	param = 3,
	condition = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_dialog_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_dialog_group, "configList", _configList)
	rawset(lua_arcade_survivor_dialog_group, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_dialog_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_dialog_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_dialog_group, "configList", nil)
	rawset(lua_arcade_survivor_dialog_group, "configDict", nil)
end

return lua_arcade_survivor_dialog_group
