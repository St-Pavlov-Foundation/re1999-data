-- chunkname: @modules/configs/excel2json/lua_copost_character.lua

module("modules.configs.excel2json.lua_copost_character", package.seeall)

local lua_copost_character = {}
local fields = {
	chaName = 3,
	chaPicture = 2,
	chaCamp = 4,
	chaId = 1
}
local primaryKey = {
	"chaId"
}
local mlStringKey = {
	chaName = 1
}
local _configList, _configDict
local configPath = "configs.copost_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_character, "configList", _configList)
	rawset(lua_copost_character, "configDict", _configDict)
end

setmetatable(lua_copost_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_character, "configList", nil)
	rawset(lua_copost_character, "configDict", nil)
end

return lua_copost_character
