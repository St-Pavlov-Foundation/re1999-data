-- chunkname: @modules/configs/excel2json/lua_dialog.lua

module("modules.configs.excel2json.lua_dialog", package.seeall)

local lua_dialog = {}
local fields = {
	id = 1,
	startGroup = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dialog, "configList", _configList)
	rawset(lua_dialog, "configDict", _configDict)
end

setmetatable(lua_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dialog, "configList", nil)
	rawset(lua_dialog, "configDict", nil)
end

return lua_dialog
