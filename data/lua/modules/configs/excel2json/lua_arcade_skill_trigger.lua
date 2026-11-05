-- chunkname: @modules/configs/excel2json/lua_arcade_skill_trigger.lua

module("modules.configs.excel2json.lua_arcade_skill_trigger", package.seeall)

local lua_arcade_skill_trigger = {}
local fields = {
	id = 1,
	effect = 4,
	condition = 2,
	triggerPoint = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_skill_trigger_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_skill_trigger, "configList", _configList)
	rawset(lua_arcade_skill_trigger, "configDict", _configDict)
end

setmetatable(lua_arcade_skill_trigger, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_skill_trigger.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_skill_trigger, "configList", nil)
	rawset(lua_arcade_skill_trigger, "configDict", nil)
end

return lua_arcade_skill_trigger
