-- chunkname: @modules/configs/excel2json/lua_survival_shelter_invasion.lua

module("modules.configs.excel2json.lua_survival_shelter_invasion", package.seeall)

local lua_survival_shelter_invasion = {}
local fields = {
	id = 1,
	stage = 3,
	round = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_shelter_invasion_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shelter_invasion, "configList", _configList)
	rawset(lua_survival_shelter_invasion, "configDict", _configDict)
end

setmetatable(lua_survival_shelter_invasion, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shelter_invasion.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shelter_invasion, "configList", nil)
	rawset(lua_survival_shelter_invasion, "configDict", nil)
end

return lua_survival_shelter_invasion
