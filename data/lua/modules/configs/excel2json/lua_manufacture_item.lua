-- chunkname: @modules/configs/excel2json/lua_manufacture_item.lua

module("modules.configs.excel2json.lua_manufacture_item", package.seeall)

local lua_manufacture_item = {}
local fields = {
	itemId = 3,
	needMat = 2,
	criProductionCount = 5,
	batchName = 6,
	showInAdvancedOrder = 10,
	orderPrice = 11,
	unitCount = 9,
	batchIcon = 7,
	needTime = 8,
	id = 1,
	criProductionId = 4,
	wholesalePrice = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	batchName = 1
}
local _configList, _configDict
local configPath = "configs.manufacture_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_manufacture_item, "configList", _configList)
	rawset(lua_manufacture_item, "configDict", _configDict)
end

setmetatable(lua_manufacture_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_manufacture_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_manufacture_item, "configList", nil)
	rawset(lua_manufacture_item, "configDict", nil)
end

return lua_manufacture_item
