-- chunkname: @modules/configs/excel2json/lua_survival_reputation.lua

module("modules.configs.excel2json.lua_survival_reputation", package.seeall)

local lua_survival_reputation = {}
local fields = {
	cost = 4,
	name = 6,
	reward = 7,
	type = 3,
	id = 1,
	icon = 5,
	lv = 2
}
local primaryKey = {
	"id",
	"lv"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_reputation_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_reputation, "configList", _configList)
	rawset(lua_survival_reputation, "configDict", _configDict)
end

setmetatable(lua_survival_reputation, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_reputation.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_reputation, "configList", nil)
	rawset(lua_survival_reputation, "configDict", nil)
end

return lua_survival_reputation
