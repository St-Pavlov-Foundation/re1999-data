-- chunkname: @modules/configs/excel2json/lua_rouge_active_skill.lua

module("modules.configs.excel2json.lua_rouge_active_skill", package.seeall)

local lua_rouge_active_skill = {}
local fields = {
	roundLimit = 5,
	icon = 8,
	coinCost = 4,
	allLimit = 6,
	id = 1,
	version = 2,
	powerCost = 3,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_active_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_active_skill, "configList", _configList)
	rawset(lua_rouge_active_skill, "configDict", _configDict)
end

setmetatable(lua_rouge_active_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_active_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_active_skill, "configList", nil)
	rawset(lua_rouge_active_skill, "configDict", nil)
end

return lua_rouge_active_skill
