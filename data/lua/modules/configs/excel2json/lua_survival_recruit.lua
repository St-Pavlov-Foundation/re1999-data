-- chunkname: @modules/configs/excel2json/lua_survival_recruit.lua

module("modules.configs.excel2json.lua_survival_recruit", package.seeall)

local lua_survival_recruit = {}
local fields = {
	showNum = 2,
	randomNum = 5,
	refreshCost = 4,
	chooseNum = 6,
	id = 1,
	cost = 8,
	refreshTimes = 3,
	unlock = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_recruit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_recruit, "configList", _configList)
	rawset(lua_survival_recruit, "configDict", _configDict)
end

setmetatable(lua_survival_recruit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_recruit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_recruit, "configList", nil)
	rawset(lua_survival_recruit, "configDict", nil)
end

return lua_survival_recruit
