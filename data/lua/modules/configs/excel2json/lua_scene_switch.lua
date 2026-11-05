-- chunkname: @modules/configs/excel2json/lua_scene_switch.lua

module("modules.configs.excel2json.lua_scene_switch", package.seeall)

local lua_scene_switch = {}
local fields = {
	eggSwitchTime = 8,
	initReportId = 9,
	itemId = 3,
	storyId = 12,
	reportSwitchTime = 10,
	previewIcon = 5,
	eggList = 7,
	resName = 6,
	previews = 11,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_switch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_switch, "configList", _configList)
	rawset(lua_scene_switch, "configDict", _configDict)
end

setmetatable(lua_scene_switch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_switch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_switch, "configList", nil)
	rawset(lua_scene_switch, "configDict", nil)
end

return lua_scene_switch
