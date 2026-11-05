-- chunkname: @modules/configs/excel2json/lua_activity123_equip_tag.lua

module("modules.configs.excel2json.lua_activity123_equip_tag", package.seeall)

local lua_activity123_equip_tag = {}
local fields = {
	id = 2,
	order = 4,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity123_equip_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_equip_tag, "configList", _configList)
	rawset(lua_activity123_equip_tag, "configDict", _configDict)
end

setmetatable(lua_activity123_equip_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_equip_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_equip_tag, "configList", nil)
	rawset(lua_activity123_equip_tag, "configDict", nil)
end

return lua_activity123_equip_tag
