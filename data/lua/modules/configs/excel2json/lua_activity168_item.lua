-- chunkname: @modules/configs/excel2json/lua_activity168_item.lua

module("modules.configs.excel2json.lua_activity168_item", package.seeall)

local lua_activity168_item = {}
local fields = {
	itemId = 2,
	name = 3,
	compostType = 5,
	type = 4,
	weight = 6,
	icon = 7,
	activityId = 1,
	desc = 8
}
local primaryKey = {
	"activityId",
	"itemId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity168_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity168_item, "configList", _configList)
	rawset(lua_activity168_item, "configDict", _configDict)
end

setmetatable(lua_activity168_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity168_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity168_item, "configList", nil)
	rawset(lua_activity168_item, "configDict", nil)
end

return lua_activity168_item
