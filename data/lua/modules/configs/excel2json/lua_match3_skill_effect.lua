-- chunkname: @modules/configs/excel2json/lua_match3_skill_effect.lua

module("modules.configs.excel2json.lua_match3_skill_effect", package.seeall)

local lua_match3_skill_effect = {}
local fields = {
	effectId = 1,
	param2 = 7,
	targetType = 4,
	param1 = 6,
	rangeType = 5,
	desc = 10,
	effectGroupId = 2,
	effectType = 3,
	countChain = 8,
	countFever = 9
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.match3_skill_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_skill_effect, "configList", _configList)
	rawset(lua_match3_skill_effect, "configDict", _configDict)
end

setmetatable(lua_match3_skill_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_skill_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_skill_effect, "configList", nil)
	rawset(lua_match3_skill_effect, "configDict", nil)
end

return lua_match3_skill_effect
