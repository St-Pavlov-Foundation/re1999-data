-- chunkname: @modules/configs/excel2json/lua_activity203_dialog.lua

module("modules.configs.excel2json.lua_activity203_dialog", package.seeall)

local lua_activity203_dialog = {}
local fields = {
	id = 1,
	dialogId = 3,
	dialogSeq = 2,
	trigger = 4
}
local primaryKey = {
	"id",
	"dialogSeq"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity203_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity203_dialog, "configList", _configList)
	rawset(lua_activity203_dialog, "configDict", _configDict)
end

setmetatable(lua_activity203_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity203_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity203_dialog, "configList", nil)
	rawset(lua_activity203_dialog, "configDict", nil)
end

return lua_activity203_dialog
