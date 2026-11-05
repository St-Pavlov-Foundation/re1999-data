-- chunkname: @modules/configs/excel2json/lua_sign_in_bonus.lua

module("modules.configs.excel2json.lua_sign_in_bonus", package.seeall)

local lua_sign_in_bonus = {}
local fields = {
	id = 1,
	signinBonus = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sign_in_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sign_in_bonus, "configList", _configList)
	rawset(lua_sign_in_bonus, "configDict", _configDict)
end

setmetatable(lua_sign_in_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sign_in_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sign_in_bonus, "configList", nil)
	rawset(lua_sign_in_bonus, "configDict", nil)
end

return lua_sign_in_bonus
