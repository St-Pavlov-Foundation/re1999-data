-- chunkname: @modules/configs/excel2json/lua_item_category_show.lua

module("modules.configs.excel2json.lua_item_category_show", package.seeall)

local lua_item_category_show = {}
local fields = {
	id = 1,
	highQuality = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.item_category_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_item_category_show, "configList", _configList)
	rawset(lua_item_category_show, "configDict", _configDict)
end

setmetatable(lua_item_category_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_item_category_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_item_category_show, "configList", nil)
	rawset(lua_item_category_show, "configDict", nil)
end

return lua_item_category_show
