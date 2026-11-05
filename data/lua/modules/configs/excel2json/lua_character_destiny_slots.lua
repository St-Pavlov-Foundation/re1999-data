-- chunkname: @modules/configs/excel2json/lua_character_destiny_slots.lua

module("modules.configs.excel2json.lua_character_destiny_slots", package.seeall)

local lua_character_destiny_slots = {}
local fields = {
	node = 3,
	effect = 5,
	consume = 4,
	stage = 2,
	slotsId = 1
}
local primaryKey = {
	"slotsId",
	"stage",
	"node"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_destiny_slots_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_destiny_slots, "configList", _configList)
	rawset(lua_character_destiny_slots, "configDict", _configDict)
end

setmetatable(lua_character_destiny_slots, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_destiny_slots.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_destiny_slots, "configList", nil)
	rawset(lua_character_destiny_slots, "configDict", nil)
end

return lua_character_destiny_slots
