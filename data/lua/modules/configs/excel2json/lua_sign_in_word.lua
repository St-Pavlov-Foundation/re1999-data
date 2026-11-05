-- chunkname: @modules/configs/excel2json/lua_sign_in_word.lua

module("modules.configs.excel2json.lua_sign_in_word", package.seeall)

local lua_sign_in_word = {}
local fields = {
	id = 1,
	signindate = 2,
	signinword = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	signinword = 1
}
local _configList, _configDict
local configPath = "configs.sign_in_word_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sign_in_word, "configList", _configList)
	rawset(lua_sign_in_word, "configDict", _configDict)
end

setmetatable(lua_sign_in_word, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sign_in_word.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sign_in_word, "configList", nil)
	rawset(lua_sign_in_word, "configDict", nil)
end

return lua_sign_in_word
