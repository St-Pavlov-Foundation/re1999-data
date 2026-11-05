-- chunkname: @modules/configs/excel2json/lua_ai_mark_skill.lua

module("modules.configs.excel2json.lua_ai_mark_skill", package.seeall)

local lua_ai_mark_skill = {}
local fields = {
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.ai_mark_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_ai_mark_skill, "configList", _configList)
	rawset(lua_ai_mark_skill, "configDict", _configDict)
end

setmetatable(lua_ai_mark_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_ai_mark_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_ai_mark_skill, "configList", nil)
	rawset(lua_ai_mark_skill, "configDict", nil)
end

return lua_ai_mark_skill
