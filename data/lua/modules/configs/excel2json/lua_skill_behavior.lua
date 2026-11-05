-- chunkname: @modules/configs/excel2json/lua_skill_behavior.lua

module("modules.configs.excel2json.lua_skill_behavior", package.seeall)

local lua_skill_behavior = {}
local fields = {
	audioId = 5,
	effect = 3,
	id = 1,
	type = 2,
	effectHangPoint = 4,
	dec_Type = 6,
	dec = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	dec = 1
}
local _configList, _configDict
local configPath = "configs.skill_behavior_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_behavior, "configList", _configList)
	rawset(lua_skill_behavior, "configDict", _configDict)
end

setmetatable(lua_skill_behavior, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_behavior.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_behavior, "configList", nil)
	rawset(lua_skill_behavior, "configDict", nil)
end

return lua_skill_behavior
