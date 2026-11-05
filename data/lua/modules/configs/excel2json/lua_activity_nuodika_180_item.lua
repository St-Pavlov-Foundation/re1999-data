-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_item.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_item", package.seeall)

local lua_activity_nuodika_180_item = {}
local fields = {
	itemId = 1,
	name = 2,
	canMove = 6,
	canEmpty = 7,
	skillID = 8,
	picture = 4,
	pictureOffset = 5,
	desc = 3
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity_nuodika_180_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_nuodika_180_item, "configList", _configList)
	rawset(lua_activity_nuodika_180_item, "configDict", _configDict)
end

setmetatable(lua_activity_nuodika_180_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_nuodika_180_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_nuodika_180_item, "configList", nil)
	rawset(lua_activity_nuodika_180_item, "configDict", nil)
end

return lua_activity_nuodika_180_item
