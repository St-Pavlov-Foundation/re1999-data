-- chunkname: @modules/configs/excel2json/lua_v4a1_library_chat_emoji.lua

module("modules.configs.excel2json.lua_v4a1_library_chat_emoji", package.seeall)

local lua_v4a1_library_chat_emoji = {}
local fields = {
	resName = 2,
	duration = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v4a1_library_chat_emoji_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v4a1_library_chat_emoji, "configList", _configList)
	rawset(lua_v4a1_library_chat_emoji, "configDict", _configDict)
end

setmetatable(lua_v4a1_library_chat_emoji, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v4a1_library_chat_emoji.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v4a1_library_chat_emoji, "configList", nil)
	rawset(lua_v4a1_library_chat_emoji, "configDict", nil)
end

return lua_v4a1_library_chat_emoji
