-- chunkname: @modules/configs/excel2json/lua_stance_pata_switch_scene.lua

module("modules.configs.excel2json.lua_stance_pata_switch_scene", package.seeall)

local lua_stance_pata_switch_scene = {}
local fields = {
	sceneId = 1,
	enemyStanceId = 3,
	myStanceId = 2
}
local primaryKey = {
	"sceneId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.stance_pata_switch_scene_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stance_pata_switch_scene, "configList", _configList)
	rawset(lua_stance_pata_switch_scene, "configDict", _configDict)
end

setmetatable(lua_stance_pata_switch_scene, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stance_pata_switch_scene.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stance_pata_switch_scene, "configList", nil)
	rawset(lua_stance_pata_switch_scene, "configDict", nil)
end

return lua_stance_pata_switch_scene
