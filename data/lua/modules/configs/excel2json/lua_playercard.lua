-- chunkname: @modules/configs/excel2json/lua_playercard.lua

module("modules.configs.excel2json.lua_playercard", package.seeall)

local lua_playercard = {}
local fields = {
	name = 3,
	type = 2,
	id = 1,
	displayPriority = 5,
	nameEn = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.playercard_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_playercard, "configList", _configList)
	rawset(lua_playercard, "configDict", _configDict)
end

setmetatable(lua_playercard, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_playercard.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_playercard, "configList", nil)
	rawset(lua_playercard, "configDict", nil)
end

return lua_playercard
