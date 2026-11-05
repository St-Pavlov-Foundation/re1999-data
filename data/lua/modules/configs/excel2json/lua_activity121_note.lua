-- chunkname: @modules/configs/excel2json/lua_activity121_note.lua

module("modules.configs.excel2json.lua_activity121_note", package.seeall)

local lua_activity121_note = {}
local fields = {
	name = 3,
	unlockType = 4,
	noteId = 1,
	fightId = 6,
	desc = 7,
	content = 8,
	activityId = 2,
	episodeId = 5
}
local primaryKey = {
	"noteId",
	"activityId"
}
local mlStringKey = {
	name = 1,
	content = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity121_note_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity121_note, "configList", _configList)
	rawset(lua_activity121_note, "configDict", _configDict)
end

setmetatable(lua_activity121_note, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity121_note.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity121_note, "configList", nil)
	rawset(lua_activity121_note, "configDict", nil)
end

return lua_activity121_note
