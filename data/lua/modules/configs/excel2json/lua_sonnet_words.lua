-- chunkname: @modules/configs/excel2json/lua_sonnet_words.lua

module("modules.configs.excel2json.lua_sonnet_words", package.seeall)

local lua_sonnet_words = {}
local fields = {
	elementId = 2,
	noteCoordinates = 6,
	coordinates = 5,
	id = 1,
	dialogId = 4,
	words = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	words = 1
}
local _configList, _configDict
local configPath = "configs.sonnet_words_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sonnet_words, "configList", _configList)
	rawset(lua_sonnet_words, "configDict", _configDict)
end

setmetatable(lua_sonnet_words, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sonnet_words.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sonnet_words, "configList", nil)
	rawset(lua_sonnet_words, "configDict", nil)
end

return lua_sonnet_words
