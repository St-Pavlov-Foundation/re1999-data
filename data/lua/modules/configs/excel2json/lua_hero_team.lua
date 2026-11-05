-- chunkname: @modules/configs/excel2json/lua_hero_team.lua

module("modules.configs.excel2json.lua_hero_team", package.seeall)

local lua_hero_team = {}
local fields = {
	isDisplay = 7,
	name = 3,
	unlockId = 4,
	actType = 2,
	minNum = 10,
	maxNum = 11,
	supNum = 6,
	isChangeName = 8,
	id = 1,
	batNum = 5,
	sort = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_team_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_team, "configList", _configList)
	rawset(lua_hero_team, "configDict", _configDict)
end

setmetatable(lua_hero_team, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_team.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_team, "configList", nil)
	rawset(lua_hero_team, "configDict", nil)
end

return lua_hero_team
