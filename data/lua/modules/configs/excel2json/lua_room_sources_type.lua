-- chunkname: @modules/configs/excel2json/lua_room_sources_type.lua

module("modules.configs.excel2json.lua_room_sources_type", package.seeall)

local lua_room_sources_type = {}
local fields = {
	showType = 7,
	name = 2,
	bgColor = 6,
	nameColor = 5,
	id = 1,
	bgIcon = 4,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.room_sources_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_sources_type, "configList", _configList)
	rawset(lua_room_sources_type, "configDict", _configDict)
end

setmetatable(lua_room_sources_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_sources_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_sources_type, "configList", nil)
	rawset(lua_room_sources_type, "configDict", nil)
end

return lua_room_sources_type
