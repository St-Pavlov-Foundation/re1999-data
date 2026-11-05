-- chunkname: @modules/configs/excel2json/lua_udimo_interact.lua

module("modules.configs.excel2json.lua_udimo_interact", package.seeall)

local lua_udimo_interact = {}
local fields = {
	isLeft = 4,
	emoji = 5,
	orderLayer = 6,
	belongBG = 1,
	groupIds = 3,
	interactId = 2
}
local primaryKey = {
	"belongBG",
	"interactId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_interact_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_interact, "configList", _configList)
	rawset(lua_udimo_interact, "configDict", _configDict)
end

setmetatable(lua_udimo_interact, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_interact.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_interact, "configList", nil)
	rawset(lua_udimo_interact, "configDict", nil)
end

return lua_udimo_interact
