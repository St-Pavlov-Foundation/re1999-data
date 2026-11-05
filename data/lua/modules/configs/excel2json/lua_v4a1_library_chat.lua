-- chunkname: @modules/configs/excel2json/lua_v4a1_library_chat.lua

module("modules.configs.excel2json.lua_v4a1_library_chat", package.seeall)

local lua_v4a1_library_chat = {}
local fields = {
	bubble1 = 2,
	bubble5 = 6,
	id = 1,
	bubble4 = 5,
	bubble3 = 4,
	bubble2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v4a1_library_chat_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v4a1_library_chat, "configList", _configList)
	rawset(lua_v4a1_library_chat, "configDict", _configDict)
end

setmetatable(lua_v4a1_library_chat, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v4a1_library_chat.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v4a1_library_chat, "configList", nil)
	rawset(lua_v4a1_library_chat, "configDict", nil)
end

return lua_v4a1_library_chat
