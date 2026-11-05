-- chunkname: @modules/configs/excel2json/lua_activity233_lv_bonus.lua

module("modules.configs.excel2json.lua_activity233_lv_bonus", package.seeall)

local lua_activity233_lv_bonus = {}
local fields = {
	keyBonus = 5,
	bpId = 1,
	payBonus = 4,
	freeBonus = 3,
	level = 2
}
local primaryKey = {
	"bpId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity233_lv_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity233_lv_bonus, "configList", _configList)
	rawset(lua_activity233_lv_bonus, "configDict", _configDict)
end

setmetatable(lua_activity233_lv_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity233_lv_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity233_lv_bonus, "configList", nil)
	rawset(lua_activity233_lv_bonus, "configDict", nil)
end

return lua_activity233_lv_bonus
