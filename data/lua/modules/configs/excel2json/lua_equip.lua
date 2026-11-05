-- chunkname: @modules/configs/excel2json/lua_equip.lua

module("modules.configs.excel2json.lua_equip", package.seeall)

local lua_equip = {}
local fields = {
	isSpRefine = 11,
	name = 2,
	name_en = 3,
	skillName = 4,
	upperLimit = 17,
	desc = 13,
	isExpEquip = 10,
	strengthType = 8,
	amplify = 18,
	tag = 9,
	icon = 5,
	sources = 15,
	useDesc = 14,
	skillType = 7,
	rare = 6,
	characterId = 19,
	id = 1,
	canShowHandbook = 16,
	useSpRefine = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillName = 2,
	name = 1,
	useDesc = 4,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.equip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip, "configList", _configList)
	rawset(lua_equip, "configDict", _configDict)
end

setmetatable(lua_equip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip, "configList", nil)
	rawset(lua_equip, "configDict", nil)
end

return lua_equip
