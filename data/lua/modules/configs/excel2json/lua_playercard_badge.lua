-- chunkname: @modules/configs/excel2json/lua_playercard_badge.lua

module("modules.configs.excel2json.lua_playercard_badge", package.seeall)

local lua_playercard_badge = {}
local fields = {
	id = 1,
	name = 2,
	taskId = 6,
	group = 4,
	icon = 3,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.playercard_badge_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_playercard_badge, "configList", _configList)
	rawset(lua_playercard_badge, "configDict", _configDict)
end

setmetatable(lua_playercard_badge, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_playercard_badge.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_playercard_badge, "configList", nil)
	rawset(lua_playercard_badge, "configDict", nil)
end

return lua_playercard_badge
