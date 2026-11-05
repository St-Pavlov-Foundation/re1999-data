-- chunkname: @modules/configs/excel2json/lua_racing_gift_group.lua

module("modules.configs.excel2json.lua_racing_gift_group", package.seeall)

local lua_racing_gift_group = {}
local fields = {
	group = 1,
	icon = 2,
	name = 3,
	desc = 4
}
local primaryKey = {
	"group"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.racing_gift_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_gift_group, "configList", _configList)
	rawset(lua_racing_gift_group, "configDict", _configDict)
end

setmetatable(lua_racing_gift_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_gift_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_gift_group, "configList", nil)
	rawset(lua_racing_gift_group, "configDict", nil)
end

return lua_racing_gift_group
