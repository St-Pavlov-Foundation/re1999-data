-- chunkname: @modules/configs/excel2json/lua_open_lang.lua

module("modules.configs.excel2json.lua_open_lang", package.seeall)

local lua_open_lang = {}
local fields = {
	id = 1,
	langStoryVoice = 4,
	langTxts = 2,
	langVoice = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.open_lang_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_open_lang, "configList", _configList)
	rawset(lua_open_lang, "configDict", _configDict)
end

setmetatable(lua_open_lang, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_open_lang.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_open_lang, "configList", nil)
	rawset(lua_open_lang, "configDict", nil)
end

return lua_open_lang
