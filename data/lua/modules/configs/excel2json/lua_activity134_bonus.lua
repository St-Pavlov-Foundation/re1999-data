-- chunkname: @modules/configs/excel2json/lua_activity134_bonus.lua

module("modules.configs.excel2json.lua_activity134_bonus", package.seeall)

local lua_activity134_bonus = {}
local fields = {
	showTab = 5,
	introduce = 8,
	desc = 7,
	id = 2,
	bonus = 10,
	title = 6,
	number = 3,
	needTokens = 11,
	storyType = 4,
	activityId = 1,
	due = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 3,
	introduce = 4,
	due = 5,
	title = 2,
	number = 1
}
local _configList, _configDict
local configPath = "configs.activity134_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity134_bonus, "configList", _configList)
	rawset(lua_activity134_bonus, "configDict", _configDict)
end

setmetatable(lua_activity134_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity134_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity134_bonus, "configList", nil)
	rawset(lua_activity134_bonus, "configDict", nil)
end

return lua_activity134_bonus
