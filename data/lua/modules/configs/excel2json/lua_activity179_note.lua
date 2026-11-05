-- chunkname: @modules/configs/excel2json/lua_activity179_note.lua

module("modules.configs.excel2json.lua_activity179_note", package.seeall)

local lua_activity179_note = {}
local fields = {
	musicId = 2,
	time = 5,
	eventName = 4,
	id = 1,
	buttonId = 3
}
local primaryKey = {
	"id",
	"musicId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity179_note_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity179_note, "configList", _configList)
	rawset(lua_activity179_note, "configDict", _configDict)
end

setmetatable(lua_activity179_note, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity179_note.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity179_note, "configList", nil)
	rawset(lua_activity179_note, "configDict", nil)
end

return lua_activity179_note
