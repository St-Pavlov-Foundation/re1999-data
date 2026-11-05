-- chunkname: @modules/configs/excel2json/lua_character_face_effect.lua

module("modules.configs.excel2json.lua_character_face_effect", package.seeall)

local lua_character_face_effect = {}
local fields = {
	node = 4,
	face = 3,
	heroResName = 1,
	effectCompName = 2
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_face_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_face_effect, "configList", _configList)
	rawset(lua_character_face_effect, "configDict", _configDict)
end

setmetatable(lua_character_face_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_face_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_face_effect, "configList", nil)
	rawset(lua_character_face_effect, "configDict", nil)
end

return lua_character_face_effect
