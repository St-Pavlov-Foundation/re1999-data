-- chunkname: @modules/configs/excel2json/lua_trad_giftbox.lua

module("modules.configs.excel2json.lua_trad_giftbox", package.seeall)

local lua_trad_giftbox = {}
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
local configPath = "configs.trad_giftbox_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trad_giftbox, "configList", _configList)
	rawset(lua_trad_giftbox, "configDict", _configDict)
end

setmetatable(lua_trad_giftbox, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trad_giftbox.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trad_giftbox, "configList", nil)
	rawset(lua_trad_giftbox, "configDict", nil)
end

return lua_trad_giftbox
