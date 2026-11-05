-- chunkname: @modules/configs/excel2json/lua_activity234_giftbox.lua

module("modules.configs.excel2json.lua_activity234_giftbox", package.seeall)

local lua_activity234_giftbox = {}
local fields = {
	iconsmall = 5,
	name = 3,
	type = 2,
	id = 1,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity234_giftbox_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity234_giftbox, "configList", _configList)
	rawset(lua_activity234_giftbox, "configDict", _configDict)
end

setmetatable(lua_activity234_giftbox, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity234_giftbox.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity234_giftbox, "configList", nil)
	rawset(lua_activity234_giftbox, "configDict", nil)
end

return lua_activity234_giftbox
