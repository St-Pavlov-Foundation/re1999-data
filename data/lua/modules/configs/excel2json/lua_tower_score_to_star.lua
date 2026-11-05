-- chunkname: @modules/configs/excel2json/lua_tower_score_to_star.lua

module("modules.configs.excel2json.lua_tower_score_to_star", package.seeall)

local lua_tower_score_to_star = {}
local fields = {
	needScore = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_score_to_star_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_score_to_star, "configList", _configList)
	rawset(lua_tower_score_to_star, "configDict", _configDict)
end

setmetatable(lua_tower_score_to_star, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_score_to_star.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_score_to_star, "configList", nil)
	rawset(lua_tower_score_to_star, "configDict", nil)
end

return lua_tower_score_to_star
