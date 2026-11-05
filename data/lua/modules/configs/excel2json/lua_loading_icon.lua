-- chunkname: @modules/configs/excel2json/lua_loading_icon.lua

module("modules.configs.excel2json.lua_loading_icon", package.seeall)

local lua_loading_icon = {}
local fields = {
	weight = 4,
	isOnline = 6,
	type = 5,
	id = 1,
	pic = 2,
	scenes = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.loading_icon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_loading_icon, "configList", _configList)
	rawset(lua_loading_icon, "configDict", _configDict)
end

setmetatable(lua_loading_icon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_loading_icon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_loading_icon, "configList", nil)
	rawset(lua_loading_icon, "configDict", nil)
end

return lua_loading_icon
