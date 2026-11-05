-- chunkname: @modules/configs/excel2json/lua_room_building_occupy.lua

module("modules.configs.excel2json.lua_room_building_occupy", package.seeall)

local lua_room_building_occupy = {}
local fields = {
	id = 1,
	icon = 2,
	occupyNum = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_building_occupy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_building_occupy, "configList", _configList)
	rawset(lua_room_building_occupy, "configDict", _configDict)
end

setmetatable(lua_room_building_occupy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_building_occupy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_building_occupy, "configList", nil)
	rawset(lua_room_building_occupy, "configDict", nil)
end

return lua_room_building_occupy
