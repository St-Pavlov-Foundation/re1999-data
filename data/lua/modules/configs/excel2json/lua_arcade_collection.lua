-- chunkname: @modules/configs/excel2json/lua_arcade_collection.lua

module("modules.configs.excel2json.lua_arcade_collection", package.seeall)

local lua_arcade_collection = {}
local fields = {
	scale = 14,
	describe = 4,
	price = 12,
	type = 3,
	name = 2,
	showTmpAttrChange = 7,
	passiveSkills = 6,
	dropWeight = 11,
	icon = 17,
	resPath = 13,
	level = 8,
	goodsWeight = 9,
	posOffset = 15,
	category = 16,
	id = 1,
	isUnique = 10,
	durable = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	describe = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_collection, "configList", _configList)
	rawset(lua_arcade_collection, "configDict", _configDict)
end

setmetatable(lua_arcade_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_collection, "configList", nil)
	rawset(lua_arcade_collection, "configDict", nil)
end

return lua_arcade_collection
