-- chunkname: @modules/configs/excel2json/lua_log_room_tag.lua

module("modules.configs.excel2json.lua_log_room_tag", package.seeall)

local lua_log_room_tag = {}
local fields = {
	id = 1,
	characterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.log_room_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_log_room_tag, "configList", _configList)
	rawset(lua_log_room_tag, "configDict", _configDict)
end

setmetatable(lua_log_room_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_log_room_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_log_room_tag, "configList", nil)
	rawset(lua_log_room_tag, "configDict", nil)
end

return lua_log_room_tag
