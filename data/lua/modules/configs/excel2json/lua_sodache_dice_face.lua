-- chunkname: @modules/configs/excel2json/lua_sodache_dice_face.lua

module("modules.configs.excel2json.lua_sodache_dice_face", package.seeall)

local lua_sodache_dice_face = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.sodache_dice_face_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_dice_face, "configList", _configList)
	rawset(lua_sodache_dice_face, "configDict", _configDict)
end

setmetatable(lua_sodache_dice_face, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_dice_face.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_dice_face, "configList", nil)
	rawset(lua_sodache_dice_face, "configDict", nil)
end

return lua_sodache_dice_face
