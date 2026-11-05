-- chunkname: @modules/configs/excel2json/lua_scene_level.lua

module("modules.configs.excel2json.lua_scene_level", package.seeall)

local lua_scene_level = {}
local fields = {
	ambientSound = 22,
	spineR = 9,
	cardCamera = 7,
	weatherEffect = 18,
	sceneId = 4,
	spineG = 10,
	useBloom = 8,
	bgm = 21,
	sceneType = 3,
	cameraId = 5,
	sceneEffects = 23,
	bloomEffect = 17,
	resName = 2,
	flyEffect = 19,
	bloomB = 14,
	bloomA = 15,
	bloomR = 12,
	cameraOffset = 6,
	flickerSceneFactor = 16,
	wadeEffect = 20,
	spineB = 11,
	id = 1,
	bloomG = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_level, "configList", _configList)
	rawset(lua_scene_level, "configDict", _configDict)
end

setmetatable(lua_scene_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_level, "configList", nil)
	rawset(lua_scene_level, "configDict", nil)
end

return lua_scene_level
