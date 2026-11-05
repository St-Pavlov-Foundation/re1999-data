-- chunkname: @modules/configs/excel2json/lua_talent_mould.lua

module("modules.configs.excel2json.lua_talent_mould", package.seeall)

local lua_talent_mould = {}
local fields = {
	type11 = 5,
	type19 = 13,
	talentMould = 2,
	type14 = 8,
	type12 = 6,
	type17 = 11,
	type15 = 9,
	type20 = 14,
	type10 = 4,
	type13 = 7,
	type18 = 12,
	allShape = 3,
	talentId = 1,
	type16 = 10
}
local primaryKey = {
	"talentId",
	"talentMould"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.talent_mould_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_mould, "configList", _configList)
	rawset(lua_talent_mould, "configDict", _configDict)
end

setmetatable(lua_talent_mould, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_mould.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_mould, "configList", nil)
	rawset(lua_talent_mould, "configDict", nil)
end

return lua_talent_mould
