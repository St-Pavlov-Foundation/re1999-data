-- chunkname: @modules/configs/excel2json/lua_activity174_test_enhance.lua

module("modules.configs.excel2json.lua_activity174_test_enhance", package.seeall)

local lua_activity174_test_enhance = {}
local fields = {
	icon = 5,
	costCoin = 6,
	id = 1,
	title = 3,
	rare = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity174_test_enhance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_test_enhance, "configList", _configList)
	rawset(lua_activity174_test_enhance, "configDict", _configDict)
end

setmetatable(lua_activity174_test_enhance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_test_enhance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_test_enhance, "configList", nil)
	rawset(lua_activity174_test_enhance, "configDict", nil)
end

return lua_activity174_test_enhance
