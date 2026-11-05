-- chunkname: @modules/configs/excel2json/lua_atomic_talent.lua

module("modules.configs.excel2json.lua_atomic_talent", package.seeall)

local lua_atomic_talent = {}
local fields = {
	cost = 10,
	name = 4,
	effect = 9,
	mark = 11,
	descType = 12,
	pic = 7,
	desc = 6,
	preNodes = 8,
	point = 3,
	id = 1,
	icon = 5,
	skillDesc = 13,
	branchId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.atomic_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_talent, "configList", _configList)
	rawset(lua_atomic_talent, "configDict", _configDict)
end

setmetatable(lua_atomic_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_talent, "configList", nil)
	rawset(lua_atomic_talent, "configDict", nil)
end

return lua_atomic_talent
