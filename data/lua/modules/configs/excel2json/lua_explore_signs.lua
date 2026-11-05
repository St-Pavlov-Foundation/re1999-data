-- chunkname: @modules/configs/excel2json/lua_explore_signs.lua

module("modules.configs.excel2json.lua_explore_signs", package.seeall)

local lua_explore_signs = {}
local fields = {
	id = 1,
	icon = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.explore_signs_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_signs, "configList", _configList)
	rawset(lua_explore_signs, "configDict", _configDict)
end

setmetatable(lua_explore_signs, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_signs.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_signs, "configList", nil)
	rawset(lua_explore_signs, "configDict", nil)
end

return lua_explore_signs
