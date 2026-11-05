-- chunkname: @modules/configs/excel2json/lua_fight_ui_style.lua

module("modules.configs.excel2json.lua_fight_ui_style", package.seeall)

local lua_fight_ui_style = {}
local fields = {
	itemId = 4,
	sort = 5,
	image = 6,
	type = 2,
	showres = 9,
	banner = 8,
	previewImage = 7,
	id = 1,
	defaultUnlock = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_ui_style_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_ui_style, "configList", _configList)
	rawset(lua_fight_ui_style, "configDict", _configDict)
end

setmetatable(lua_fight_ui_style, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_ui_style.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_ui_style, "configList", nil)
	rawset(lua_fight_ui_style, "configDict", nil)
end

return lua_fight_ui_style
