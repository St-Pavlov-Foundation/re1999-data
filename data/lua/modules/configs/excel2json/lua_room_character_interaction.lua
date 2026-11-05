-- chunkname: @modules/configs/excel2json/lua_room_character_interaction.lua

module("modules.configs.excel2json.lua_room_character_interaction", package.seeall)

local lua_room_character_interaction = {}
local fields = {
	buildingAudio = 10,
	variety = 3,
	rate = 5,
	dialogId = 17,
	faithDialog = 19,
	excludeDaily = 20,
	conditionStr = 22,
	buildingAnimState = 13,
	heroId = 2,
	weather = 4,
	buildingCameraIds = 11,
	behaviour = 6,
	buildingNode = 12,
	reward = 18,
	showtime = 21,
	buildingInside = 8,
	heroAnimState = 14,
	buildingId = 7,
	buildingInsideSpines = 9,
	id = 1,
	relateHeroId = 16,
	delayEnterBuilding = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_character_interaction_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character_interaction, "configList", _configList)
	rawset(lua_room_character_interaction, "configDict", _configDict)
end

setmetatable(lua_room_character_interaction, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character_interaction.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character_interaction, "configList", nil)
	rawset(lua_room_character_interaction, "configDict", nil)
end

return lua_room_character_interaction
