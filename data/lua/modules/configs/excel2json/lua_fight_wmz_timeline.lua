-- chunkname: @modules/configs/excel2json/lua_fight_wmz_timeline.lua

module("modules.configs.excel2json.lua_fight_wmz_timeline", package.seeall)

local lua_fight_wmz_timeline = {}
local fields = {
	id = 2,
	skin = 1,
	timeline = 3
}
local primaryKey = {
	"skin",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_wmz_timeline_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_wmz_timeline, "configList", _configList)
	rawset(lua_fight_wmz_timeline, "configDict", _configDict)
end

setmetatable(lua_fight_wmz_timeline, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_wmz_timeline.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_wmz_timeline, "configList", nil)
	rawset(lua_fight_wmz_timeline, "configDict", nil)
end

return lua_fight_wmz_timeline
