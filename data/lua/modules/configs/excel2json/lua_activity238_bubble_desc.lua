-- chunkname: @modules/configs/excel2json/lua_activity238_bubble_desc.lua

module("modules.configs.excel2json.lua_activity238_bubble_desc", package.seeall)

local lua_activity238_bubble_desc = {}
local fields = {
	id = 1,
	duration = 2,
	posXY = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity238_bubble_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity238_bubble_desc, "configList", _configList)
	rawset(lua_activity238_bubble_desc, "configDict", _configDict)
end

setmetatable(lua_activity238_bubble_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity238_bubble_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity238_bubble_desc, "configList", nil)
	rawset(lua_activity238_bubble_desc, "configDict", nil)
end

return lua_activity238_bubble_desc
