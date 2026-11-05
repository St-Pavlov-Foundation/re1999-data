-- chunkname: @modules/configs/excel2json/lua_tower_assist_boss_change.lua

module("modules.configs.excel2json.lua_tower_assist_boss_change", package.seeall)

local lua_tower_assist_boss_change = {}
local fields = {
	bossId = 1,
	activeSkills = 5,
	passiveSkills = 6,
	skinId = 3,
	form = 2,
	coldTime = 4,
	replacePassiveSkills = 7,
	resMaxVal = 8
}
local primaryKey = {
	"bossId",
	"form"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_assist_boss_change_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_assist_boss_change, "configList", _configList)
	rawset(lua_tower_assist_boss_change, "configDict", _configDict)
end

setmetatable(lua_tower_assist_boss_change, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_assist_boss_change.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_assist_boss_change, "configList", nil)
	rawset(lua_tower_assist_boss_change, "configDict", nil)
end

return lua_tower_assist_boss_change
