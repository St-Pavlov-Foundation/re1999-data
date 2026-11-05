-- chunkname: @modules/configs/excel2json/lua_activity163_dialog.lua

module("modules.configs.excel2json.lua_activity163_dialog", package.seeall)

local lua_activity163_dialog = {}
local fields = {
	expression = 9,
	content = 7,
	nextStep = 3,
	pos = 5,
	stepId = 2,
	condition = 8,
	speaker = 4,
	speakerIcon = 6,
	id = 1
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	speaker = 1,
	content = 2
}
local _configList, _configDict
local configPath = "configs.activity163_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity163_dialog, "configList", _configList)
	rawset(lua_activity163_dialog, "configDict", _configDict)
end

setmetatable(lua_activity163_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity163_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity163_dialog, "configList", nil)
	rawset(lua_activity163_dialog, "configDict", nil)
end

return lua_activity163_dialog
