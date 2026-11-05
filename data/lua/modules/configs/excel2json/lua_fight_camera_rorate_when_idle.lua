-- chunkname: @modules/configs/excel2json/lua_fight_camera_rorate_when_idle.lua

module("modules.configs.excel2json.lua_fight_camera_rorate_when_idle", package.seeall)

local lua_fight_camera_rorate_when_idle = {}
local fields = {
	id = 1,
	invokeRotateImmediately = 3,
	offset = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_camera_rorate_when_idle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_camera_rorate_when_idle, "configList", _configList)
	rawset(lua_fight_camera_rorate_when_idle, "configDict", _configDict)
end

setmetatable(lua_fight_camera_rorate_when_idle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_camera_rorate_when_idle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_camera_rorate_when_idle, "configList", nil)
	rawset(lua_fight_camera_rorate_when_idle, "configDict", nil)
end

return lua_fight_camera_rorate_when_idle
