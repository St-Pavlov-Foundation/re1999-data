-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_event.lua

module("modules.configs.excel2json.lua_arcade_survivor_event", package.seeall)

local lua_arcade_survivor_event = {}
local fields = {
	skillIds = 8,
	popupImage = 4,
	needSkillId = 6,
	imgOffset = 5,
	id = 1,
	title = 2,
	ruleIds = 7,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1,
	ruleIds = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_event, "configList", _configList)
	rawset(lua_arcade_survivor_event, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_event, "configList", nil)
	rawset(lua_arcade_survivor_event, "configDict", nil)
end

return lua_arcade_survivor_event
