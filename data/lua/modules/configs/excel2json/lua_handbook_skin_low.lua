-- chunkname: @modules/configs/excel2json/lua_handbook_skin_low.lua

module("modules.configs.excel2json.lua_handbook_skin_low", package.seeall)

local lua_handbook_skin_low = {}
local fields = {
	backImg = 8,
	name = 2,
	des = 6,
	includeSuit = 12,
	spineParams = 9,
	tarotCardPath = 10,
	festivalParams = 11,
	show = 5,
	skinContain = 7,
	highId = 4,
	id = 1,
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
local configPath = "configs.handbook_skin_low_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_skin_low, "configList", _configList)
	rawset(lua_handbook_skin_low, "configDict", _configDict)
end

setmetatable(lua_handbook_skin_low, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_skin_low.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_skin_low, "configList", nil)
	rawset(lua_handbook_skin_low, "configDict", nil)
end

return lua_handbook_skin_low
