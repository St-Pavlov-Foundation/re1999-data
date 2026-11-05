-- chunkname: @modules/configs/excel2json/lua_assassin_trap.lua

module("modules.configs.excel2json.lua_assassin_trap", package.seeall)

local lua_assassin_trap = {}
local fields = {
	effectId = 5,
	effect = 3,
	type = 2,
	trapId = 1,
	duration = 4
}
local primaryKey = {
	"trapId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_trap_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_trap, "configList", _configList)
	rawset(lua_assassin_trap, "configDict", _configDict)
end

setmetatable(lua_assassin_trap, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_trap.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_trap, "configList", nil)
	rawset(lua_assassin_trap, "configDict", nil)
end

return lua_assassin_trap
