-- chunkname: @modules/configs/excel2json/lua_survival_shelter.lua

module("modules.configs.excel2json.lua_survival_shelter", package.seeall)

local lua_survival_shelter = {}
local fields = {
	versions = 5,
	difficultLv = 3,
	maxNpcNum = 7,
	orderPosition = 9,
	shelterId = 4,
	npcPosition = 12,
	toward = 10,
	stormCenter = 13,
	stormArea = 14,
	mapId = 11,
	seasons = 2,
	id = 1,
	position = 8,
	shelterChange = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_shelter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shelter, "configList", _configList)
	rawset(lua_survival_shelter, "configDict", _configDict)
end

setmetatable(lua_survival_shelter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shelter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shelter, "configList", nil)
	rawset(lua_survival_shelter, "configDict", nil)
end

return lua_survival_shelter
