-- chunkname: @modules/configs/excel2json/lua_tower_talent_plan.lua

module("modules.configs.excel2json.lua_tower_talent_plan", package.seeall)

local lua_tower_talent_plan = {}
local fields = {
	bossId = 1,
	talentIds = 3,
	planId = 2,
	planName = 4
}
local primaryKey = {
	"bossId",
	"planId"
}
local mlStringKey = {
	planName = 1
}
local _configList, _configDict
local configPath = "configs.tower_talent_plan_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_talent_plan, "configList", _configList)
	rawset(lua_tower_talent_plan, "configDict", _configDict)
end

setmetatable(lua_tower_talent_plan, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_talent_plan.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_talent_plan, "configList", nil)
	rawset(lua_tower_talent_plan, "configDict", nil)
end

return lua_tower_talent_plan
