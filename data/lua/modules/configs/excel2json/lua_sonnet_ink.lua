-- chunkname: @modules/configs/excel2json/lua_sonnet_ink.lua

module("modules.configs.excel2json.lua_sonnet_ink", package.seeall)

local lua_sonnet_ink = {}
local fields = {
	id = 1,
	wordsGroup = 2,
	poemId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sonnet_ink_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sonnet_ink, "configList", _configList)
	rawset(lua_sonnet_ink, "configDict", _configDict)
end

setmetatable(lua_sonnet_ink, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sonnet_ink.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sonnet_ink, "configList", nil)
	rawset(lua_sonnet_ink, "configDict", nil)
end

return lua_sonnet_ink
