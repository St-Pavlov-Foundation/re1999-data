-- chunkname: @modules/configs/excel2json/lua_v4a1_library_char.lua

module("modules.configs.excel2json.lua_v4a1_library_char", package.seeall)

local lua_v4a1_library_char = {}
local fields = {
	sortingOrder = 8,
	walkableArea = 5,
	idleDurationRange = 4,
	collider2DSize = 6,
	chatIds = 9,
	emojiPos = 11,
	chatPos = 10,
	speed = 3,
	collider2DOffset = 7,
	id = 1,
	scale = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v4a1_library_char_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v4a1_library_char, "configList", _configList)
	rawset(lua_v4a1_library_char, "configDict", _configDict)
end

setmetatable(lua_v4a1_library_char, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v4a1_library_char.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v4a1_library_char, "configList", nil)
	rawset(lua_v4a1_library_char, "configDict", nil)
end

return lua_v4a1_library_char
