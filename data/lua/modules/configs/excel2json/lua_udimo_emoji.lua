-- chunkname: @modules/configs/excel2json/lua_udimo_emoji.lua

module("modules.configs.excel2json.lua_udimo_emoji", package.seeall)

local lua_udimo_emoji = {}
local fields = {
	id = 1,
	resource = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_emoji_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_emoji, "configList", _configList)
	rawset(lua_udimo_emoji, "configDict", _configDict)
end

setmetatable(lua_udimo_emoji, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_emoji.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_emoji, "configList", nil)
	rawset(lua_udimo_emoji, "configDict", nil)
end

return lua_udimo_emoji
