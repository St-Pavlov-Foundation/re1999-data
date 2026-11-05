-- chunkname: @modules/configs/excel2json/lua_card_heat.lua

module("modules.configs.excel2json.lua_card_heat", package.seeall)

local lua_card_heat = {}
local fields = {
	id = 1,
	desc = 3,
	descParam = 4,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.card_heat_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_card_heat, "configList", _configList)
	rawset(lua_card_heat, "configDict", _configDict)
end

setmetatable(lua_card_heat, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_card_heat.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_card_heat, "configList", nil)
	rawset(lua_card_heat, "configDict", nil)
end

return lua_card_heat
