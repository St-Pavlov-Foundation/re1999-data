-- chunkname: @modules/configs/excel2json/lua_explore_chest.lua

module("modules.configs.excel2json.lua_explore_chest", package.seeall)

local lua_explore_chest = {}
local fields = {
	bonus = 4,
	isCount = 5,
	chapterId = 3,
	id = 1,
	episodeId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.explore_chest_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_chest, "configList", _configList)
	rawset(lua_explore_chest, "configDict", _configDict)
end

setmetatable(lua_explore_chest, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_chest.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_chest, "configList", nil)
	rawset(lua_explore_chest, "configDict", nil)
end

return lua_explore_chest
