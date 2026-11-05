-- chunkname: @modules/configs/excel2json/lua_activity203_soldier.lua

module("modules.configs.excel2json.lua_activity203_soldier", package.seeall)

local lua_activity203_soldier = {}
local fields = {
	description = 4,
	passiveSkill = 8,
	hP = 5,
	type = 2,
	name = 3,
	icon = 9,
	animation = 11,
	resource = 6,
	speed = 7,
	soldierId = 1,
	scale = 10
}
local primaryKey = {
	"soldierId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity203_soldier_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity203_soldier, "configList", _configList)
	rawset(lua_activity203_soldier, "configDict", _configDict)
end

setmetatable(lua_activity203_soldier, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity203_soldier.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity203_soldier, "configList", nil)
	rawset(lua_activity203_soldier, "configDict", nil)
end

return lua_activity203_soldier
