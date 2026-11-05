-- chunkname: @modules/configs/excel2json/lua_role_badge.lua

module("modules.configs.excel2json.lua_role_badge", package.seeall)

local lua_role_badge = {}
local fields = {
	sortId = 8,
	listenerType = 5,
	icon = 10,
	groupId = 2,
	badgeTitle = 3,
	desc = 4,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	level = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	badgeTitle = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.role_badge_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_role_badge, "configList", _configList)
	rawset(lua_role_badge, "configDict", _configDict)
end

setmetatable(lua_role_badge, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_role_badge.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_role_badge, "configList", nil)
	rawset(lua_role_badge, "configDict", nil)
end

return lua_role_badge
