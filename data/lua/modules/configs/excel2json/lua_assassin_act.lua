-- chunkname: @modules/configs/excel2json/lua_assassin_act.lua

module("modules.configs.excel2json.lua_assassin_act", package.seeall)

local lua_assassin_act = {}
local fields = {
	param = 8,
	name = 2,
	icon = 3,
	type = 7,
	id = 1,
	effectId = 10,
	desc = 9,
	audioId = 5,
	power = 6,
	showImg = 4,
	targetEffectId = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.assassin_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_act, "configList", _configList)
	rawset(lua_assassin_act, "configDict", _configDict)
end

setmetatable(lua_assassin_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_act, "configList", nil)
	rawset(lua_assassin_act, "configDict", nil)
end

return lua_assassin_act
