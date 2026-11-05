-- chunkname: @modules/configs/excel2json/lua_activity114_motion.lua

module("modules.configs.excel2json.lua_activity114_motion", package.seeall)

local lua_activity114_motion = {}
local fields = {
	param = 3,
	face = 5,
	type = 2,
	id = 1,
	motion = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	face = 1
}
local _configList, _configDict
local configPath = "configs.activity114_motion_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_motion, "configList", _configList)
	rawset(lua_activity114_motion, "configDict", _configDict)
end

setmetatable(lua_activity114_motion, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_motion.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_motion, "configList", nil)
	rawset(lua_activity114_motion, "configDict", nil)
end

return lua_activity114_motion
