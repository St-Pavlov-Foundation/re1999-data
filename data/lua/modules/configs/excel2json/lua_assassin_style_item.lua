-- chunkname: @modules/configs/excel2json/lua_assassin_style_item.lua

module("modules.configs.excel2json.lua_assassin_style_item", package.seeall)

local lua_assassin_style_item = {}
local fields = {
	allLimit = 3,
	icon = 6,
	skillId = 1,
	roundLimit = 2,
	itemSpace = 5,
	desc = 4
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.assassin_style_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_style_item, "configList", _configList)
	rawset(lua_assassin_style_item, "configDict", _configDict)
end

setmetatable(lua_assassin_style_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_style_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_style_item, "configList", nil)
	rawset(lua_assassin_style_item, "configDict", nil)
end

return lua_assassin_style_item
