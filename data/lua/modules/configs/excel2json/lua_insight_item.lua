-- chunkname: @modules/configs/excel2json/lua_insight_item.lua

module("modules.configs.excel2json.lua_insight_item", package.seeall)

local lua_insight_item = {}
local fields = {
	heroRares = 5,
	name = 2,
	useDesc = 8,
	heroRank = 6,
	desc = 9,
	effect = 11,
	rare = 4,
	expireHours = 7,
	sources = 12,
	useTitle = 10,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	useTitle = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.insight_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_insight_item, "configList", _configList)
	rawset(lua_insight_item, "configDict", _configDict)
end

setmetatable(lua_insight_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_insight_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_insight_item, "configList", nil)
	rawset(lua_insight_item, "configDict", nil)
end

return lua_insight_item
