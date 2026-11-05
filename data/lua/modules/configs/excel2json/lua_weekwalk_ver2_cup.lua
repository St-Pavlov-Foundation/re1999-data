-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_cup.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_cup", package.seeall)

local lua_weekwalk_ver2_cup = {}
local fields = {
	fightType = 3,
	layerId = 2,
	progressDesc = 10,
	desc1 = 6,
	paramOfProgressDesc = 11,
	cupNo = 4,
	desc = 9,
	desc2 = 7,
	id = 1,
	cupTask = 5,
	desc3 = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc3 = 3,
	desc2 = 2,
	progressDesc = 5,
	desc1 = 1,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.weekwalk_ver2_cup_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_ver2_cup, "configList", _configList)
	rawset(lua_weekwalk_ver2_cup, "configDict", _configDict)
end

setmetatable(lua_weekwalk_ver2_cup, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_ver2_cup.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_ver2_cup, "configList", nil)
	rawset(lua_weekwalk_ver2_cup, "configDict", nil)
end

return lua_weekwalk_ver2_cup
