-- chunkname: @modules/configs/excel2json/lua_chapter_map_element_dialog.lua

module("modules.configs.excel2json.lua_chapter_map_element_dialog", package.seeall)

local lua_chapter_map_element_dialog = {}
local fields = {
	param = 4,
	res = 8,
	audio = 5,
	type = 3,
	id = 1,
	speaker = 6,
	content = 7,
	stepId = 2
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
local configPath = "configs.chapter_map_element_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_map_element_dialog, "configList", _configList)
	rawset(lua_chapter_map_element_dialog, "configDict", _configDict)
end

setmetatable(lua_chapter_map_element_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_map_element_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_map_element_dialog, "configList", nil)
	rawset(lua_chapter_map_element_dialog, "configDict", nil)
end

return lua_chapter_map_element_dialog
