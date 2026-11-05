-- chunkname: @modules/configs/excel2json/lua_activity133_bonus.lua

module("modules.configs.excel2json.lua_activity133_bonus", package.seeall)

local lua_activity133_bonus = {}
local fields = {
	finalBonus = 9,
	title = 3,
	pos = 8,
	desc = 4,
	needTokens = 7,
	id = 2,
	icon = 5,
	activityId = 1,
	bonus = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity133_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity133_bonus, "configList", _configList)
	rawset(lua_activity133_bonus, "configDict", _configDict)
end

setmetatable(lua_activity133_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity133_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity133_bonus, "configList", nil)
	rawset(lua_activity133_bonus, "configDict", nil)
end

return lua_activity133_bonus
