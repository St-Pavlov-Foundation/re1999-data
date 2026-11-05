-- chunkname: @modules/configs/excel2json/lua_auto_chess_composite_selector.lua

module("modules.configs.excel2json.lua_auto_chess_composite_selector", package.seeall)

local lua_auto_chess_composite_selector = {}
local fields = {
	id = 1,
	param = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_composite_selector_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_composite_selector, "configList", _configList)
	rawset(lua_auto_chess_composite_selector, "configDict", _configDict)
end

setmetatable(lua_auto_chess_composite_selector, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_composite_selector.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_composite_selector, "configList", nil)
	rawset(lua_auto_chess_composite_selector, "configDict", nil)
end

return lua_auto_chess_composite_selector
