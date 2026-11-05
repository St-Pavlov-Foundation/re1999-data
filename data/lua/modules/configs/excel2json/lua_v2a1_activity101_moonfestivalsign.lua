-- chunkname: @modules/configs/excel2json/lua_v2a1_activity101_moonfestivalsign.lua

module("modules.configs.excel2json.lua_v2a1_activity101_moonfestivalsign", package.seeall)

local lua_v2a1_activity101_moonfestivalsign = {}
local fields = {
	desc = 3,
	titile = 4,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	titile = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.v2a1_activity101_moonfestivalsign_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a1_activity101_moonfestivalsign, "configList", _configList)
	rawset(lua_v2a1_activity101_moonfestivalsign, "configDict", _configDict)
end

setmetatable(lua_v2a1_activity101_moonfestivalsign, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a1_activity101_moonfestivalsign.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a1_activity101_moonfestivalsign, "configList", nil)
	rawset(lua_v2a1_activity101_moonfestivalsign, "configDict", nil)
end

return lua_v2a1_activity101_moonfestivalsign
