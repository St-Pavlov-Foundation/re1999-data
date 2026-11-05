-- chunkname: @modules/configs/excel2json/lua_atomic_fight_element.lua

module("modules.configs.excel2json.lua_atomic_fight_element", package.seeall)

local lua_atomic_fight_element = {}
local fields = {
	showType = 3,
	id = 1,
	param = 4,
	type = 2,
	desc = 9,
	title = 8,
	reward = 10,
	episodeId = 5,
	randomEpisodeIds = 6,
	roundWarning = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.atomic_fight_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_fight_element, "configList", _configList)
	rawset(lua_atomic_fight_element, "configDict", _configDict)
end

setmetatable(lua_atomic_fight_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_fight_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_fight_element, "configList", nil)
	rawset(lua_atomic_fight_element, "configDict", nil)
end

return lua_atomic_fight_element
