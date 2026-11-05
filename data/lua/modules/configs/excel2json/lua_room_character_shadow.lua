-- chunkname: @modules/configs/excel2json/lua_room_character_shadow.lua

module("modules.configs.excel2json.lua_room_character_shadow", package.seeall)

local lua_room_character_shadow = {}
local fields = {
	animName = 2,
	shadow = 3,
	skinId = 1
}
local primaryKey = {
	"skinId",
	"animName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_character_shadow_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character_shadow, "configList", _configList)
	rawset(lua_room_character_shadow, "configDict", _configDict)
end

setmetatable(lua_room_character_shadow, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character_shadow.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character_shadow, "configList", nil)
	rawset(lua_room_character_shadow, "configDict", nil)
end

return lua_room_character_shadow
