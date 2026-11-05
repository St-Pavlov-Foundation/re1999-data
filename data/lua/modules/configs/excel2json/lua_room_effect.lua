-- chunkname: @modules/configs/excel2json/lua_room_effect.lua

module("modules.configs.excel2json.lua_room_effect", package.seeall)

local lua_room_effect = {}
local fields = {
	id = 1,
	duration = 3,
	resPath = 2,
	audioId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_effect, "configList", _configList)
	rawset(lua_room_effect, "configDict", _configDict)
end

setmetatable(lua_room_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_effect, "configList", nil)
	rawset(lua_room_effect, "configDict", nil)
end

return lua_room_effect
