-- chunkname: @modules/configs/excel2json/lua_room_building.lua

module("modules.configs.excel2json.lua_room_building", package.seeall)

local lua_room_building = {}
local fields = {
	alphaThreshold = 22,
	name = 4,
	rotate = 18,
	sound = 24,
	gatherDesc = 17,
	buildingType = 7,
	useDesc = 5,
	path = 23,
	canPlaceBlock = 33,
	canLevelUp = 37,
	sourcesType = 13,
	vehicleType = 31,
	isAreaMainBuilding = 38,
	icon = 8,
	center = 3,
	buildDegree = 28,
	sources = 14,
	vehicleId = 32,
	buildingShowType = 15,
	audioExtendIds = 27,
	rare = 10,
	produceDesc = 16,
	id = 1,
	rewardIcon = 9,
	nameEn = 12,
	uiScale = 20,
	audioExtendType = 26,
	canExchange = 39,
	desc = 6,
	linkBlock = 35,
	placeAudio = 25,
	crossload = 30,
	areaId = 2,
	costResource = 29,
	replaceBlock = 34,
	offset = 19,
	numLimit = 11,
	reflerction = 36,
	dragUpHeight = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	produceDesc = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.room_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_building, "configList", _configList)
	rawset(lua_room_building, "configDict", _configDict)
end

setmetatable(lua_room_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_building, "configList", nil)
	rawset(lua_room_building, "configDict", nil)
end

return lua_room_building
