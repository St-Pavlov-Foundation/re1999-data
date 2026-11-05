-- chunkname: @modules/configs/excel2json/lua_activity233_bp.lua

module("modules.configs.excel2json.lua_activity233_bp", package.seeall)

local lua_activity233_bp = {}
local fields = {
	unlockPremiumCost = 4,
	bpId = 1,
	activityId = 2,
	expLevelUp = 3
}
local primaryKey = {
	"bpId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity233_bp_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity233_bp, "configList", _configList)
	rawset(lua_activity233_bp, "configDict", _configDict)
end

setmetatable(lua_activity233_bp, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity233_bp.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity233_bp, "configList", nil)
	rawset(lua_activity233_bp, "configDict", nil)
end

return lua_activity233_bp
