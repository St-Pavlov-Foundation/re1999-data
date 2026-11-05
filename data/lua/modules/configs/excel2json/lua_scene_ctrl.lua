-- chunkname: @modules/configs/excel2json/lua_scene_ctrl.lua

module("modules.configs.excel2json.lua_scene_ctrl", package.seeall)

local lua_scene_ctrl = {}
local fields = {
	resName = 1,
	param2 = 4,
	param1 = 3,
	param4 = 6,
	ctrlName = 2,
	param3 = 5
}
local primaryKey = {
	"resName",
	"ctrlName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_ctrl_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_ctrl, "configList", _configList)
	rawset(lua_scene_ctrl, "configDict", _configDict)
end

setmetatable(lua_scene_ctrl, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_ctrl.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_ctrl, "configList", nil)
	rawset(lua_scene_ctrl, "configDict", nil)
end

return lua_scene_ctrl
