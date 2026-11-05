-- chunkname: @modules/configs/excel2json/lua_activity206_dialogue.lua

module("modules.configs.excel2json.lua_activity206_dialogue", package.seeall)

local lua_activity206_dialogue = {}
local fields = {
	roleName = 4,
	roleIcon = 3,
	chaseId = 2,
	dialog = 6,
	roleNameEn = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"chaseId"
}
local mlStringKey = {
	roleName = 1,
	dialog = 2
}
local _configList, _configDict
local configPath = "configs.activity206_dialogue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity206_dialogue, "configList", _configList)
	rawset(lua_activity206_dialogue, "configDict", _configDict)
end

setmetatable(lua_activity206_dialogue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity206_dialogue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity206_dialogue, "configList", nil)
	rawset(lua_activity206_dialogue, "configDict", nil)
end

return lua_activity206_dialogue
