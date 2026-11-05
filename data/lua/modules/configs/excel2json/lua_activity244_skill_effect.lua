-- chunkname: @modules/configs/excel2json/lua_activity244_skill_effect.lua

module("modules.configs.excel2json.lua_activity244_skill_effect", package.seeall)

local lua_activity244_skill_effect = {}
local fields = {
	type = 2,
	effectId = 1
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_skill_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_skill_effect, "configList", _configList)
	rawset(lua_activity244_skill_effect, "configDict", _configDict)
end

setmetatable(lua_activity244_skill_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_skill_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_skill_effect, "configList", nil)
	rawset(lua_activity244_skill_effect, "configDict", nil)
end

return lua_activity244_skill_effect
