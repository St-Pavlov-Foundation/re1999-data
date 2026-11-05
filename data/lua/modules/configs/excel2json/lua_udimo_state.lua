-- chunkname: @modules/configs/excel2json/lua_udimo_state.lua

module("modules.configs.excel2json.lua_udimo_state", package.seeall)

local lua_udimo_state = {}
local fields = {
	emoji = 3,
	param = 4,
	udimoId = 1,
	state = 2
}
local primaryKey = {
	"udimoId",
	"state"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_state_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_state, "configList", _configList)
	rawset(lua_udimo_state, "configDict", _configDict)
end

setmetatable(lua_udimo_state, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_state.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_state, "configList", nil)
	rawset(lua_udimo_state, "configDict", nil)
end

return lua_udimo_state
