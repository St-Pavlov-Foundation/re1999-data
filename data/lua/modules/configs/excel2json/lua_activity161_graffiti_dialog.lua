-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti_dialog.lua

module("modules.configs.excel2json.lua_activity161_graffiti_dialog", package.seeall)

local lua_activity161_graffiti_dialog = {}
local fields = {
	stepId = 2,
	dialogId = 1,
	chessId = 3,
	dialog = 4
}
local primaryKey = {
	"dialogId",
	"stepId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity161_graffiti_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity161_graffiti_dialog, "configList", _configList)
	rawset(lua_activity161_graffiti_dialog, "configDict", _configDict)
end

setmetatable(lua_activity161_graffiti_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity161_graffiti_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity161_graffiti_dialog, "configList", nil)
	rawset(lua_activity161_graffiti_dialog, "configDict", nil)
end

return lua_activity161_graffiti_dialog
