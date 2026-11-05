-- chunkname: @modules/configs/excel2json/lua_explore_bubble.lua

module("modules.configs.excel2json.lua_explore_bubble", package.seeall)

local lua_explore_bubble = {}
local fields = {
	id = 1,
	content = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.explore_bubble_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_bubble, "configList", _configList)
	rawset(lua_explore_bubble, "configDict", _configDict)
end

setmetatable(lua_explore_bubble, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_bubble.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_bubble, "configList", nil)
	rawset(lua_explore_bubble, "configDict", nil)
end

return lua_explore_bubble
