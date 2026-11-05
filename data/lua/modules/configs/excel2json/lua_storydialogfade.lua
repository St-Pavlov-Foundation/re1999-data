-- chunkname: @modules/configs/excel2json/lua_storydialogfade.lua

module("modules.configs.excel2json.lua_storydialogfade", package.seeall)

local lua_storydialogfade = {}
local fields = {
	id = 1,
	skipvideo = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.storydialogfade_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_storydialogfade, "configList", _configList)
	rawset(lua_storydialogfade, "configDict", _configDict)
end

setmetatable(lua_storydialogfade, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_storydialogfade.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_storydialogfade, "configList", nil)
	rawset(lua_storydialogfade, "configDict", nil)
end

return lua_storydialogfade
