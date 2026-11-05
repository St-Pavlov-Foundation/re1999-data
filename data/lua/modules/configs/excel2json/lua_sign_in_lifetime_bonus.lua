-- chunkname: @modules/configs/excel2json/lua_sign_in_lifetime_bonus.lua

module("modules.configs.excel2json.lua_sign_in_lifetime_bonus", package.seeall)

local lua_sign_in_lifetime_bonus = {}
local fields = {
	logindaysid = 2,
	stagetitle = 3,
	bonus = 4,
	stageid = 1
}
local primaryKey = {
	"stageid"
}
local mlStringKey = {
	stagetitle = 1
}
local _configList, _configDict
local configPath = "configs.sign_in_lifetime_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sign_in_lifetime_bonus, "configList", _configList)
	rawset(lua_sign_in_lifetime_bonus, "configDict", _configDict)
end

setmetatable(lua_sign_in_lifetime_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sign_in_lifetime_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sign_in_lifetime_bonus, "configList", nil)
	rawset(lua_sign_in_lifetime_bonus, "configDict", nil)
end

return lua_sign_in_lifetime_bonus
