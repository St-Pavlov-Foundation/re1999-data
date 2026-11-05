-- chunkname: @modules/configs/excel2json/lua_odyssey_fight_element.lua

module("modules.configs.excel2json.lua_odyssey_fight_element", package.seeall)

local lua_odyssey_fight_element = {}
local fields = {
	reward = 7,
	desc = 6,
	param = 3,
	type = 2,
	enemyLevel = 9,
	title = 5,
	episodeId = 4,
	randomDrop = 8,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_fight_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_fight_element, "configList", _configList)
	rawset(lua_odyssey_fight_element, "configDict", _configDict)
end

setmetatable(lua_odyssey_fight_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_fight_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_fight_element, "configList", nil)
	rawset(lua_odyssey_fight_element, "configDict", nil)
end

return lua_odyssey_fight_element
