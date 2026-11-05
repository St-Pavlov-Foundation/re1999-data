-- chunkname: @modules/configs/excel2json/lua_activity244_skill_target.lua

module("modules.configs.excel2json.lua_activity244_skill_target", package.seeall)

local lua_activity244_skill_target = {}
local fields = {
	targetId = 1,
	targetType = 2
}
local primaryKey = {
	"targetId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_skill_target_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_skill_target, "configList", _configList)
	rawset(lua_activity244_skill_target, "configDict", _configDict)
end

setmetatable(lua_activity244_skill_target, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_skill_target.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_skill_target, "configList", nil)
	rawset(lua_activity244_skill_target, "configDict", nil)
end

return lua_activity244_skill_target
