-- chunkname: @modules/configs/excel2json/lua_critter_tag.lua

module("modules.configs.excel2json.lua_critter_tag", package.seeall)

local lua_critter_tag = {}
local fields = {
	id = 1,
	name = 7,
	inheritance = 10,
	type = 2,
	group = 3,
	luckyItemIds = 12,
	luckyItemType = 11,
	desc = 8,
	effects = 9,
	needAttributeLevel = 4,
	skillIcon = 5,
	filterTag = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.critter_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_tag, "configList", _configList)
	rawset(lua_critter_tag, "configDict", _configDict)
end

setmetatable(lua_critter_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_tag, "configList", nil)
	rawset(lua_critter_tag, "configDict", nil)
end

return lua_critter_tag
