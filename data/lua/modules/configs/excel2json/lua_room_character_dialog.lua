-- chunkname: @modules/configs/excel2json/lua_room_character_dialog.lua

module("modules.configs.excel2json.lua_room_character_dialog", package.seeall)

local lua_room_character_dialog = {}
local fields = {
	selectIds = 7,
	relateContent = 6,
	speaker = 3,
	stepId = 2,
	content = 4,
	critteremoji = 5,
	speakerType = 8,
	dialogId = 1,
	nextStepId = 9
}
local primaryKey = {
	"dialogId",
	"stepId"
}
local mlStringKey = {
	speaker = 1,
	relateContent = 3,
	content = 2
}
local _configList, _configDict
local configPath = "configs.room_character_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character_dialog, "configList", _configList)
	rawset(lua_room_character_dialog, "configDict", _configDict)
end

setmetatable(lua_room_character_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character_dialog, "configList", nil)
	rawset(lua_room_character_dialog, "configDict", nil)
end

return lua_room_character_dialog
