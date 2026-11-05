-- chunkname: @modules/configs/excel2json/lua_scene_eggs.lua

module("modules.configs.excel2json.lua_scene_eggs", package.seeall)

local lua_scene_eggs = {}
local fields = {
	parallel = 5,
	actionClass = 3,
	id = 1,
	actionParams = 4,
	path = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_eggs_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_eggs, "configList", _configList)
	rawset(lua_scene_eggs, "configDict", _configDict)
end

setmetatable(lua_scene_eggs, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_eggs.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_eggs, "configList", nil)
	rawset(lua_scene_eggs, "configDict", nil)
end

return lua_scene_eggs
