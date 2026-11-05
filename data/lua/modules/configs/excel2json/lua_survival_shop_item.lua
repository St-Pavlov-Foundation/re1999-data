-- chunkname: @modules/configs/excel2json/lua_survival_shop_item.lua

module("modules.configs.excel2json.lua_survival_shop_item", package.seeall)

local lua_survival_shop_item = {}
local fields = {
	groupId = 2,
	item = 6,
	worthFix = 5,
	type = 3,
	id = 1,
	maxNum = 7,
	unlock = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_shop_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shop_item, "configList", _configList)
	rawset(lua_survival_shop_item, "configDict", _configDict)
end

setmetatable(lua_survival_shop_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shop_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shop_item, "configList", nil)
	rawset(lua_survival_shop_item, "configDict", nil)
end

return lua_survival_shop_item
