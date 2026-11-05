-- chunkname: @modules/configs/excel2json/lua_dialog_step.lua

module("modules.configs.excel2json.lua_dialog_step", package.seeall)

local lua_dialog_step = {}
local fields = {
	id = 2,
	name = 5,
	avatar = 6,
	type = 3,
	groupId = 1,
	chessId = 7,
	content = 4
}
local primaryKey = {
	"groupId",
	"id"
}
local mlStringKey = {
	content = 1,
	name = 2
}
local _configList, _configDict
local configPath = "configs.dialog_step_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dialog_step, "configList", _configList)
	rawset(lua_dialog_step, "configDict", _configDict)
end

setmetatable(lua_dialog_step, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dialog_step.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dialog_step, "configList", nil)
	rawset(lua_dialog_step, "configDict", nil)
end

return lua_dialog_step
