-- chunkname: @modules/configs/excel2json/lua_bonus.lua

module("modules.configs.excel2json.lua_bonus", package.seeall)

local lua_bonus = {}
local fields = {
	dailyGainLimit = 2,
	fixBonus = 6,
	score = 5,
	heroExp = 3,
	id = 1,
	bonusView = 7,
	dailyGainWarning = 8,
	playerExp = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bonus, "configList", _configList)
	rawset(lua_bonus, "configDict", _configDict)
end

setmetatable(lua_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bonus, "configList", nil)
	rawset(lua_bonus, "configDict", nil)
end

return lua_bonus
