-- chunkname: @modules/configs/excel2json/lua_room_character_dialog_select.lua

module("modules.configs.excel2json.lua_room_character_dialog_select", package.seeall)

local lua_room_character_dialog_select = {}
local fields = {
	id = 1,
	dialogId = 2,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.room_character_dialog_select_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character_dialog_select, "configList", _configList)
	rawset(lua_room_character_dialog_select, "configDict", _configDict)
end

setmetatable(lua_room_character_dialog_select, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character_dialog_select.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character_dialog_select, "configList", nil)
	rawset(lua_room_character_dialog_select, "configDict", nil)
end

return lua_room_character_dialog_select
