-- chunkname: @modules/configs/excel2json/lua_sonnet_poem.lua

module("modules.configs.excel2json.lua_sonnet_poem", package.seeall)

local lua_sonnet_poem = {}
local fields = {
	poem = 2,
	id = 1,
	audioId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	poem = 1
}
local _configList, _configDict
local configPath = "configs.sonnet_poem_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sonnet_poem, "configList", _configList)
	rawset(lua_sonnet_poem, "configDict", _configDict)
end

setmetatable(lua_sonnet_poem, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sonnet_poem.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sonnet_poem, "configList", nil)
	rawset(lua_sonnet_poem, "configDict", nil)
end

return lua_sonnet_poem
