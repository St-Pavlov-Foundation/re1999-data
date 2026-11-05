-- chunkname: @modules/configs/excel2json/lua_rouge2_boss_assess.lua

module("modules.configs.excel2json.lua_rouge2_boss_assess", package.seeall)

local lua_rouge2_boss_assess = {}
local fields = {
	spriteName = 4,
	needScore = 3,
	strLevel = 2,
	isHard = 6,
	bossIcon = 5,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_boss_assess_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_boss_assess, "configList", _configList)
	rawset(lua_rouge2_boss_assess, "configDict", _configDict)
end

setmetatable(lua_rouge2_boss_assess, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_boss_assess.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_boss_assess, "configList", nil)
	rawset(lua_rouge2_boss_assess, "configDict", nil)
end

return lua_rouge2_boss_assess
