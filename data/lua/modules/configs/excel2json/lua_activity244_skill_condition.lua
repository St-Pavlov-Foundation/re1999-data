-- chunkname: @modules/configs/excel2json/lua_activity244_skill_condition.lua

module("modules.configs.excel2json.lua_activity244_skill_condition", package.seeall)

local lua_activity244_skill_condition = {}
local fields = {
	id = 1,
	condition = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_skill_condition_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_skill_condition, "configList", _configList)
	rawset(lua_activity244_skill_condition, "configDict", _configDict)
end

setmetatable(lua_activity244_skill_condition, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_skill_condition.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_skill_condition, "configList", nil)
	rawset(lua_activity244_skill_condition, "configDict", nil)
end

return lua_activity244_skill_condition
