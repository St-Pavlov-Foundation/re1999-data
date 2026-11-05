-- chunkname: @modules/configs/excel2json/lua_sonnet_dialog.lua

module("modules.configs.excel2json.lua_sonnet_dialog", package.seeall)

local lua_sonnet_dialog = {}
local fields = {
	index = 2,
	elementId = 1,
	desc = 3
}
local primaryKey = {
	"elementId",
	"index"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.sonnet_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sonnet_dialog, "configList", _configList)
	rawset(lua_sonnet_dialog, "configDict", _configDict)
end

setmetatable(lua_sonnet_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sonnet_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sonnet_dialog, "configList", nil)
	rawset(lua_sonnet_dialog, "configDict", nil)
end

return lua_sonnet_dialog
