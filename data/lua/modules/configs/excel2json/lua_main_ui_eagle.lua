-- chunkname: @modules/configs/excel2json/lua_main_ui_eagle.lua

module("modules.configs.excel2json.lua_main_ui_eagle", package.seeall)

local lua_main_ui_eagle = {}
local fields = {
	animName = 5,
	location = 8,
	odds_nextstep = 2,
	isoutline = 9,
	playfadeAnim = 10,
	times = 7,
	loop = 6,
	isSpineAnim = 4,
	id = 1,
	option_nextstep = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.main_ui_eagle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_main_ui_eagle, "configList", _configList)
	rawset(lua_main_ui_eagle, "configDict", _configDict)
end

setmetatable(lua_main_ui_eagle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_main_ui_eagle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_main_ui_eagle, "configList", nil)
	rawset(lua_main_ui_eagle, "configDict", nil)
end

return lua_main_ui_eagle
