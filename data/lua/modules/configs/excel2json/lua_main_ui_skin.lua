-- chunkname: @modules/configs/excel2json/lua_main_ui_skin.lua

module("modules.configs.excel2json.lua_main_ui_skin", package.seeall)

local lua_main_ui_skin = {}
local fields = {
	iconAnchor = 4,
	name = 7,
	showChild = 8,
	skinId = 2,
	id = 1,
	icon = 3,
	iconRotate = 5,
	isLangBg = 6
}
local primaryKey = {
	"id",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.main_ui_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_main_ui_skin, "configList", _configList)
	rawset(lua_main_ui_skin, "configDict", _configDict)
end

setmetatable(lua_main_ui_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_main_ui_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_main_ui_skin, "configList", nil)
	rawset(lua_main_ui_skin, "configDict", nil)
end

return lua_main_ui_skin
