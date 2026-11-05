-- chunkname: @modules/configs/excel2json/lua_rouge2_interactive.lua

module("modules.configs.excel2json.lua_rouge2_interactive", package.seeall)

local lua_rouge2_interactive = {}
local fields = {
	tips = 2,
	id = 1,
	typeParam = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_interactive_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_interactive, "configList", _configList)
	rawset(lua_rouge2_interactive, "configDict", _configDict)
end

setmetatable(lua_rouge2_interactive, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_interactive.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_interactive, "configList", nil)
	rawset(lua_rouge2_interactive, "configDict", nil)
end

return lua_rouge2_interactive
