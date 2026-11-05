-- chunkname: @modules/configs/excel2json/lua_activity178_talent.lua

module("modules.configs.excel2json.lua_activity178_talent", package.seeall)

local lua_activity178_talent = {}
local fields = {
	isBig = 7,
	name = 3,
	effect = 11,
	cost = 12,
	condition = 9,
	desc = 8,
	needLv = 10,
	point = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	root = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity178_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_talent, "configList", _configList)
	rawset(lua_activity178_talent, "configDict", _configDict)
end

setmetatable(lua_activity178_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_talent, "configList", nil)
	rawset(lua_activity178_talent, "configDict", nil)
end

return lua_activity178_talent
