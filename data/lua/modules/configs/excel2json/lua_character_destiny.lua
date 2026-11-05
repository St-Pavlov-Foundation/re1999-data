-- chunkname: @modules/configs/excel2json/lua_character_destiny.lua

module("modules.configs.excel2json.lua_character_destiny", package.seeall)

local lua_character_destiny = {}
local fields = {
	facetsId = 3,
	heroId = 1,
	slotsId = 2
}
local primaryKey = {
	"heroId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_destiny_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_destiny, "configList", _configList)
	rawset(lua_character_destiny, "configDict", _configDict)
end

setmetatable(lua_character_destiny, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_destiny.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_destiny, "configList", nil)
	rawset(lua_character_destiny, "configDict", nil)
end

return lua_character_destiny
