-- chunkname: @modules/configs/excel2json/lua_fight_replace_timeline.lua

module("modules.configs.excel2json.lua_fight_replace_timeline", package.seeall)

local lua_fight_replace_timeline = {}
local fields = {
	condition = 6,
	priority = 3,
	timeline = 2,
	id = 1,
	target = 4,
	simulate = 5
}
local primaryKey = {
	"id",
	"timeline"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_replace_timeline_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_replace_timeline, "configList", _configList)
	rawset(lua_fight_replace_timeline, "configDict", _configDict)
end

setmetatable(lua_fight_replace_timeline, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_replace_timeline.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_replace_timeline, "configList", nil)
	rawset(lua_fight_replace_timeline, "configDict", nil)
end

return lua_fight_replace_timeline
