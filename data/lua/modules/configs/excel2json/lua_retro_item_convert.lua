-- chunkname: @modules/configs/excel2json/lua_retro_item_convert.lua

module("modules.configs.excel2json.lua_retro_item_convert", package.seeall)

local lua_retro_item_convert = {}
local fields = {
	itemId = 2,
	limit = 3,
	version = 5,
	typeId = 1,
	price = 4
}
local primaryKey = {
	"typeId",
	"itemId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.retro_item_convert_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_retro_item_convert, "configList", _configList)
	rawset(lua_retro_item_convert, "configDict", _configDict)
end

setmetatable(lua_retro_item_convert, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_retro_item_convert.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_retro_item_convert, "configList", nil)
	rawset(lua_retro_item_convert, "configDict", nil)
end

return lua_retro_item_convert
