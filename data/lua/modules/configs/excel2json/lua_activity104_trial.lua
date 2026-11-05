-- chunkname: @modules/configs/excel2json/lua_activity104_trial.lua

module("modules.configs.excel2json.lua_activity104_trial", package.seeall)

local lua_activity104_trial = {}
local fields = {
	equipId = 8,
	firstPassEquipIds = 5,
	name = 6,
	nameEn = 7,
	episodeId = 3,
	unlockLayer = 4,
	activityId = 1,
	layer = 2
}
local primaryKey = {
	"activityId",
	"layer"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity104_trial_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_trial, "configList", _configList)
	rawset(lua_activity104_trial, "configDict", _configDict)
end

setmetatable(lua_activity104_trial, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_trial.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_trial, "configList", nil)
	rawset(lua_activity104_trial, "configDict", nil)
end

return lua_activity104_trial
