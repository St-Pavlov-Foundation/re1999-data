-- chunkname: @modules/configs/excel2json/lua_fight_eziozhuangbei.lua

module("modules.configs.excel2json.lua_fight_eziozhuangbei", package.seeall)

local lua_fight_eziozhuangbei = {}
local fields = {
	skillEx = 9,
	passiveSkill = 6,
	firstId = 1,
	secondId = 2,
	skillGroup1 = 7,
	skillGroup2 = 8,
	skillLevel = 3,
	secondDesc = 5,
	firstDesc = 4,
	exchangeSkills = 10
}
local primaryKey = {
	"firstId",
	"secondId",
	"skillLevel"
}
local mlStringKey = {
	secondDesc = 2,
	firstDesc = 1
}
local _configList, _configDict
local configPath = "configs.fight_eziozhuangbei_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_eziozhuangbei, "configList", _configList)
	rawset(lua_fight_eziozhuangbei, "configDict", _configDict)
end

setmetatable(lua_fight_eziozhuangbei, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_eziozhuangbei.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_eziozhuangbei, "configList", nil)
	rawset(lua_fight_eziozhuangbei, "configDict", nil)
end

return lua_fight_eziozhuangbei
