-- chunkname: @modules/configs/excel2json/lua_milestone_bonus.lua

module("modules.configs.excel2json.lua_milestone_bonus", package.seeall)

local lua_milestone_bonus = {}
local fields = {
	needProgress = 3,
	special = 5,
	bonusId = 2,
	milestoneId = 1,
	bonus = 4
}
local primaryKey = {
	"milestoneId",
	"bonusId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.milestone_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_milestone_bonus, "configList", _configList)
	rawset(lua_milestone_bonus, "configDict", _configDict)
end

setmetatable(lua_milestone_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_milestone_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_milestone_bonus, "configList", nil)
	rawset(lua_milestone_bonus, "configDict", nil)
end

return lua_milestone_bonus
