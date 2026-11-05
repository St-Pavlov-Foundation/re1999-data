-- chunkname: @modules/configs/excel2json/lua_chat_check.lua

module("modules.configs.excel2json.lua_chat_check", package.seeall)

local lua_chat_check = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 1
}
local _configList, _configDict
local configPath = "configs.chat_check_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chat_check, "configList", _configList)
	rawset(lua_chat_check, "configDict", _configDict)
end

setmetatable(lua_chat_check, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chat_check.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chat_check, "configList", nil)
	rawset(lua_chat_check, "configDict", nil)
end

return lua_chat_check
