-- chunkname: @modules/configs/excel2json/lua_activity246.lua

module("modules.configs.excel2json.lua_activity246", package.seeall)

local lua_activity246 = {}
local fields = {
	cardId = 2,
	cost = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"cardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity246_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity246, "configList", _configList)
	rawset(lua_activity246, "configDict", _configDict)
end

setmetatable(lua_activity246, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity246.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity246, "configList", nil)
	rawset(lua_activity246, "configDict", nil)
end

return lua_activity246
