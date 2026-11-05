-- chunkname: @modules/configs/excel2json/lua_main_banner.lua

module("modules.configs.excel2json.lua_main_banner", package.seeall)

local lua_main_banner = {}
local fields = {
	sortId = 4,
	name = 2,
	jumpId = 5,
	appearanceRole = 7,
	id = 1,
	icon = 3,
	startEnd = 6,
	vanishingRule = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.main_banner_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_main_banner, "configList", _configList)
	rawset(lua_main_banner, "configDict", _configDict)
end

setmetatable(lua_main_banner, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_main_banner.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_main_banner, "configList", nil)
	rawset(lua_main_banner, "configDict", nil)
end

return lua_main_banner
