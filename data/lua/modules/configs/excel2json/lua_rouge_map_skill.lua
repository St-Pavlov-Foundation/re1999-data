-- chunkname: @modules/configs/excel2json/lua_rouge_map_skill.lua

module("modules.configs.excel2json.lua_rouge_map_skill", package.seeall)

local lua_rouge_map_skill = {}
local fields = {
	icon = 9,
	stepCd = 5,
	middleLayerLimit = 10,
	desc = 8,
	effects = 7,
	coinCost = 4,
	id = 1,
	version = 2,
	powerCost = 3,
	useLimit = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_map_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_map_skill, "configList", _configList)
	rawset(lua_rouge_map_skill, "configDict", _configDict)
end

setmetatable(lua_rouge_map_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_map_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_map_skill, "configList", nil)
	rawset(lua_rouge_map_skill, "configDict", nil)
end

return lua_rouge_map_skill
