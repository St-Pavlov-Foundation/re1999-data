-- chunkname: @modules/configs/excel2json/lua_assassin_quest_type.lua

module("modules.configs.excel2json.lua_assassin_quest_type", package.seeall)

local lua_assassin_quest_type = {}
local fields = {
	icon = 3,
	name = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.assassin_quest_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_quest_type, "configList", _configList)
	rawset(lua_assassin_quest_type, "configDict", _configDict)
end

setmetatable(lua_assassin_quest_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_quest_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_quest_type, "configList", nil)
	rawset(lua_assassin_quest_type, "configDict", nil)
end

return lua_assassin_quest_type
