-- chunkname: @modules/configs/excel2json/lua_activity108_dialog.lua

module("modules.configs.excel2json.lua_activity108_dialog", package.seeall)

local lua_activity108_dialog = {}
local fields = {
	param = 4,
	stepId = 2,
	option_param = 5,
	type = 3,
	id = 1,
	result = 6,
	content = 7
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity108_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_dialog, "configList", _configList)
	rawset(lua_activity108_dialog, "configDict", _configDict)
end

setmetatable(lua_activity108_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_dialog, "configList", nil)
	rawset(lua_activity108_dialog, "configDict", nil)
end

return lua_activity108_dialog
