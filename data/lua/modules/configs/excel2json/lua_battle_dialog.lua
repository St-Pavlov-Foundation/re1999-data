-- chunkname: @modules/configs/excel2json/lua_battle_dialog.lua

module("modules.configs.excel2json.lua_battle_dialog", package.seeall)

local lua_battle_dialog = {}
local fields = {
	param = 3,
	icon = 7,
	canRepeat = 4,
	random = 6,
	delay = 11,
	text = 9,
	type = 12,
	insideRepeat = 5,
	audioId = 8,
	id = 2,
	code = 1,
	tipsDir = 10
}
local primaryKey = {
	"code",
	"id"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.battle_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_battle_dialog, "configList", _configList)
	rawset(lua_battle_dialog, "configDict", _configDict)
end

setmetatable(lua_battle_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_battle_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_battle_dialog, "configList", nil)
	rawset(lua_battle_dialog, "configDict", nil)
end

return lua_battle_dialog
