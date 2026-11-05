-- chunkname: @modules/configs/excel2json/lua_activity145_movement.lua

module("modules.configs.excel2json.lua_activity145_movement", package.seeall)

local lua_activity145_movement = {}
local fields = {
	displayTime = 5,
	type = 2,
	id = 1,
	motion = 3,
	content = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	motion = 1
}
local _configList, _configDict
local configPath = "configs.activity145_movement_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity145_movement, "configList", _configList)
	rawset(lua_activity145_movement, "configDict", _configDict)
end

setmetatable(lua_activity145_movement, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity145_movement.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity145_movement, "configList", nil)
	rawset(lua_activity145_movement, "configDict", nil)
end

return lua_activity145_movement
