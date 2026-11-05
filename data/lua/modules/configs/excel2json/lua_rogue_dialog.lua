-- chunkname: @modules/configs/excel2json/lua_rogue_dialog.lua

module("modules.configs.excel2json.lua_rogue_dialog", package.seeall)

local lua_rogue_dialog = {}
local fields = {
	text = 3,
	id = 2,
	photo = 5,
	type = 4,
	group = 1
}
local primaryKey = {
	"group",
	"id"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.rogue_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_dialog, "configList", _configList)
	rawset(lua_rogue_dialog, "configDict", _configDict)
end

setmetatable(lua_rogue_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_dialog, "configList", nil)
	rawset(lua_rogue_dialog, "configDict", nil)
end

return lua_rogue_dialog
