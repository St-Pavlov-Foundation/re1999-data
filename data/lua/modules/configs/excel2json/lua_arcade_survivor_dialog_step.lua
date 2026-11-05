-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_dialog_step.lua

module("modules.configs.excel2json.lua_arcade_survivor_dialog_step", package.seeall)

local lua_arcade_survivor_dialog_step = {}
local fields = {
	avatar = 5,
	name = 4,
	groupId = 1,
	content = 3,
	step = 2
}
local primaryKey = {
	"groupId",
	"step"
}
local mlStringKey = {
	content = 1,
	name = 2
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_dialog_step_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_dialog_step, "configList", _configList)
	rawset(lua_arcade_survivor_dialog_step, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_dialog_step, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_dialog_step.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_dialog_step, "configList", nil)
	rawset(lua_arcade_survivor_dialog_step, "configDict", nil)
end

return lua_arcade_survivor_dialog_step
