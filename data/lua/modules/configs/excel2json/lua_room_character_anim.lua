-- chunkname: @modules/configs/excel2json/lua_room_character_anim.lua

module("modules.configs.excel2json.lua_room_character_anim", package.seeall)

local lua_room_character_anim = {}
local fields = {
	animName = 2,
	upTime = 3,
	upDuration = 4,
	downDuration = 7,
	id = 1,
	downTime = 6,
	upDistance = 5,
	cameraState = 8
}
local primaryKey = {
	"id",
	"animName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_character_anim_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character_anim, "configList", _configList)
	rawset(lua_room_character_anim, "configDict", _configDict)
end

setmetatable(lua_room_character_anim, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character_anim.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character_anim, "configList", nil)
	rawset(lua_room_character_anim, "configDict", nil)
end

return lua_room_character_anim
