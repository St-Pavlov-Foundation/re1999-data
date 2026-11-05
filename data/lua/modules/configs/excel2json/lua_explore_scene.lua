-- chunkname: @modules/configs/excel2json/lua_explore_scene.lua

module("modules.configs.excel2json.lua_explore_scene", package.seeall)

local lua_explore_scene = {}
local fields = {
	sceneId = 4,
	signsId = 5,
	chapterId = 1,
	id = 3,
	episodeId = 2
}
local primaryKey = {
	"chapterId",
	"episodeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.explore_scene_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_scene, "configList", _configList)
	rawset(lua_explore_scene, "configDict", _configDict)
end

setmetatable(lua_explore_scene, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_scene.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_scene, "configList", nil)
	rawset(lua_explore_scene, "configDict", nil)
end

return lua_explore_scene
