-- chunkname: @modules/configs/excel2json/lua_handbook_skin_high.lua

module("modules.configs.excel2json.lua_handbook_skin_high", package.seeall)

local lua_handbook_skin_high = {}
local fields = {
	scenePath = 7,
	name = 2,
	order = 5,
	des = 6,
	show = 4,
	iconRes = 9,
	id = 1,
	nameRes = 8,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.handbook_skin_high_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_skin_high, "configList", _configList)
	rawset(lua_handbook_skin_high, "configDict", _configDict)
end

setmetatable(lua_handbook_skin_high, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_skin_high.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_skin_high, "configList", nil)
	rawset(lua_handbook_skin_high, "configDict", nil)
end

return lua_handbook_skin_high
