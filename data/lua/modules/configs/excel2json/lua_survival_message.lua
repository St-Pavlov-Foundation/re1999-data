-- chunkname: @modules/configs/excel2json/lua_survival_message.lua

module("modules.configs.excel2json.lua_survival_message", package.seeall)

local lua_survival_message = {}
local fields = {
	id = 1,
	type = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_message_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_message, "configList", _configList)
	rawset(lua_survival_message, "configDict", _configDict)
end

setmetatable(lua_survival_message, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_message.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_message, "configList", nil)
	rawset(lua_survival_message, "configDict", nil)
end

return lua_survival_message
