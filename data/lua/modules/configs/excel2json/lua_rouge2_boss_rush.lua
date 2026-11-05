-- chunkname: @modules/configs/excel2json/lua_rouge2_boss_rush.lua

module("modules.configs.excel2json.lua_rouge2_boss_rush", package.seeall)

local lua_rouge2_boss_rush = {}
local fields = {
	reward = 7,
	tag = 5,
	bossIcon = 3,
	tabIcon = 4,
	levelId = 2,
	resultBossIcon = 8,
	id = 1,
	battleInfo = 6,
	resultTitleIcon = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag = 1,
	battleInfo = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_boss_rush_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_boss_rush, "configList", _configList)
	rawset(lua_rouge2_boss_rush, "configDict", _configDict)
end

setmetatable(lua_rouge2_boss_rush, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_boss_rush.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_boss_rush, "configList", nil)
	rawset(lua_rouge2_boss_rush, "configDict", nil)
end

return lua_rouge2_boss_rush
