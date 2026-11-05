-- chunkname: @modules/configs/excel2json/lua_fight_appear_timeline_extend.lua

module("modules.configs.excel2json.lua_fight_appear_timeline_extend", package.seeall)

local lua_fight_appear_timeline_extend = {}
local fields = {
	groupId = 1,
	monsterIdList = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_appear_timeline_extend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_appear_timeline_extend, "configList", _configList)
	rawset(lua_fight_appear_timeline_extend, "configDict", _configDict)
end

setmetatable(lua_fight_appear_timeline_extend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_appear_timeline_extend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_appear_timeline_extend, "configList", nil)
	rawset(lua_fight_appear_timeline_extend, "configDict", nil)
end

return lua_fight_appear_timeline_extend
