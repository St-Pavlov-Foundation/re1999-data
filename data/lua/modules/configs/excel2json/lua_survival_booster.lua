-- chunkname: @modules/configs/excel2json/lua_survival_booster.lua

module("modules.configs.excel2json.lua_survival_booster", package.seeall)

local lua_survival_booster = {}
local fields = {
	id = 1,
	name = 2,
	tag = 6,
	effectDesc = 3,
	icon = 5,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 2,
	name = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.survival_booster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_booster, "configList", _configList)
	rawset(lua_survival_booster, "configDict", _configDict)
end

setmetatable(lua_survival_booster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_booster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_booster, "configList", nil)
	rawset(lua_survival_booster, "configDict", nil)
end

return lua_survival_booster
