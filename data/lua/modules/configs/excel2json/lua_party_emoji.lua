-- chunkname: @modules/configs/excel2json/lua_party_emoji.lua

module("modules.configs.excel2json.lua_party_emoji", package.seeall)

local lua_party_emoji = {}
local fields = {
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.party_emoji_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_emoji, "configList", _configList)
	rawset(lua_party_emoji, "configDict", _configDict)
end

setmetatable(lua_party_emoji, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_emoji.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_emoji, "configList", nil)
	rawset(lua_party_emoji, "configDict", nil)
end

return lua_party_emoji
