-- chunkname: @modules/configs/excel2json/lua_college_story_dialog.lua

module("modules.configs.excel2json.lua_college_story_dialog", package.seeall)

local lua_college_story_dialog = {}
local fields = {
	name = 5,
	type = 7,
	stepId = 2,
	picture = 3,
	desc = 6,
	effectType = 8,
	id = 1,
	position = 4,
	effectParam = 9
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.college_story_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_story_dialog, "configList", _configList)
	rawset(lua_college_story_dialog, "configDict", _configDict)
end

setmetatable(lua_college_story_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_story_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_story_dialog, "configList", nil)
	rawset(lua_college_story_dialog, "configDict", nil)
end

return lua_college_story_dialog
