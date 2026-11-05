-- chunkname: @modules/configs/excel2json/lua_dialog_group.lua

module("modules.configs.excel2json.lua_dialog_group", package.seeall)

local lua_dialog_group = {}
local fields = {
	dialogue_id = 1,
	id = 2
}
local primaryKey = {
	"dialogue_id",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dialog_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dialog_group, "configList", _configList)
	rawset(lua_dialog_group, "configDict", _configDict)
end

setmetatable(lua_dialog_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dialog_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dialog_group, "configList", nil)
	rawset(lua_dialog_group, "configDict", nil)
end

return lua_dialog_group
