-- chunkname: @modules/configs/excel2json/lua_v3a5_text.lua

module("modules.configs.excel2json.lua_v3a5_text", package.seeall)

local lua_v3a5_text = {}
local fields = {
	text = 3,
	voiceId = 5,
	id = 1,
	characterId = 2,
	groupId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.v3a5_text_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a5_text, "configList", _configList)
	rawset(lua_v3a5_text, "configDict", _configDict)
end

setmetatable(lua_v3a5_text, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a5_text.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a5_text, "configList", nil)
	rawset(lua_v3a5_text, "configDict", nil)
end

return lua_v3a5_text
