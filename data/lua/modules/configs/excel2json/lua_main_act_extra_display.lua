-- chunkname: @modules/configs/excel2json/lua_main_act_extra_display.lua

module("modules.configs.excel2json.lua_main_act_extra_display", package.seeall)

local lua_main_act_extra_display = {}
local fields = {
	sortId = 4,
	name = 2,
	id = 1,
	icon = 3,
	show = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.main_act_extra_display_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_main_act_extra_display, "configList", _configList)
	rawset(lua_main_act_extra_display, "configDict", _configDict)
end

setmetatable(lua_main_act_extra_display, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_main_act_extra_display.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_main_act_extra_display, "configList", nil)
	rawset(lua_main_act_extra_display, "configDict", nil)
end

return lua_main_act_extra_display
