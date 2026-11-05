-- chunkname: @modules/configs/excel2json/lua_weekwalk_bonus.lua

module("modules.configs.excel2json.lua_weekwalk_bonus", package.seeall)

local lua_weekwalk_bonus = {}
local fields = {
	bonusId = 3,
	bonusGroup = 1,
	bonus = 2
}
local primaryKey = {
	"bonusGroup"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_bonus, "configList", _configList)
	rawset(lua_weekwalk_bonus, "configDict", _configDict)
end

setmetatable(lua_weekwalk_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_bonus, "configList", nil)
	rawset(lua_weekwalk_bonus, "configDict", nil)
end

return lua_weekwalk_bonus
