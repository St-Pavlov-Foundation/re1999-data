-- chunkname: @modules/configs/excel2json/lua_weekwalk_dialog.lua

module("modules.configs.excel2json.lua_weekwalk_dialog", package.seeall)

local lua_weekwalk_dialog = {}
local fields = {
	param = 4,
	single = 6,
	option_param = 5,
	type = 3,
	id = 1,
	stepId = 2,
	content = 8,
	speaker = 7
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
local configPath = "configs.weekwalk_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_dialog, "configList", _configList)
	rawset(lua_weekwalk_dialog, "configDict", _configDict)
end

setmetatable(lua_weekwalk_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_dialog, "configList", nil)
	rawset(lua_weekwalk_dialog, "configDict", nil)
end

return lua_weekwalk_dialog
