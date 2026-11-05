-- chunkname: @modules/configs/excel2json/lua_activity174_test_role.lua

module("modules.configs.excel2json.lua_activity174_test_role", package.seeall)

local lua_activity174_test_role = {}
local fields = {
	heroId = 7,
	name = 8,
	costCoin = 19,
	type = 2,
	uniqueSkill = 16,
	gender = 9,
	career = 10,
	activeSkill2 = 15,
	quality = 5,
	activeSkill1 = 14,
	dmgType = 11,
	uniqueSkill_point = 17,
	skinId = 4,
	powerMax = 18,
	passiveSkill = 12,
	rare = 6,
	template = 3,
	id = 1,
	replacePassiveSkill = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity174_test_role_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_test_role, "configList", _configList)
	rawset(lua_activity174_test_role, "configDict", _configDict)
end

setmetatable(lua_activity174_test_role, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_test_role.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_test_role, "configList", nil)
	rawset(lua_activity174_test_role, "configDict", nil)
end

return lua_activity174_test_role
