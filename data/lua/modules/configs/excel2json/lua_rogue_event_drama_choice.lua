-- chunkname: @modules/configs/excel2json/lua_rogue_event_drama_choice.lua

module("modules.configs.excel2json.lua_rogue_event_drama_choice", package.seeall)

local lua_rogue_event_drama_choice = {}
local fields = {
	dialogId = 7,
	event = 9,
	collection = 10,
	type = 2,
	group = 3,
	title = 5,
	condition = 4,
	desc = 6,
	id = 1,
	icon = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rogue_event_drama_choice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_drama_choice, "configList", _configList)
	rawset(lua_rogue_event_drama_choice, "configDict", _configDict)
end

setmetatable(lua_rogue_event_drama_choice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_drama_choice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_drama_choice, "configList", nil)
	rawset(lua_rogue_event_drama_choice, "configDict", nil)
end

return lua_rogue_event_drama_choice
