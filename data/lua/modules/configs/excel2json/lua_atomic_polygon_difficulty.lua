-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_difficulty.lua

module("modules.configs.excel2json.lua_atomic_polygon_difficulty", package.seeall)

local lua_atomic_polygon_difficulty = {}
local fields = {
	description = 7,
	name = 6,
	image = 5,
	unlockCondition = 4,
	episodeId = 8,
	skillId = 9,
	id = 1,
	difficulty = 2,
	conditionType = 3
}
local primaryKey = {
	"id",
	"difficulty"
}
local mlStringKey = {
	description = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.atomic_polygon_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_polygon_difficulty, "configList", _configList)
	rawset(lua_atomic_polygon_difficulty, "configDict", _configDict)
end

setmetatable(lua_atomic_polygon_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_polygon_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_polygon_difficulty, "configList", nil)
	rawset(lua_atomic_polygon_difficulty, "configDict", nil)
end

return lua_atomic_polygon_difficulty
