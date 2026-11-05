-- chunkname: @modules/configs/excel2json/lua_v4a1_library_chat_desc.lua

module("modules.configs.excel2json.lua_v4a1_library_chat_desc", package.seeall)

local lua_v4a1_library_chat_desc = {}
local fields = {
	id = 1,
	duration = 4,
	desc = 3,
	nextId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.v4a1_library_chat_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v4a1_library_chat_desc, "configList", _configList)
	rawset(lua_v4a1_library_chat_desc, "configDict", _configDict)
end

setmetatable(lua_v4a1_library_chat_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v4a1_library_chat_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v4a1_library_chat_desc, "configList", nil)
	rawset(lua_v4a1_library_chat_desc, "configDict", nil)
end

return lua_v4a1_library_chat_desc
