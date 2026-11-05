-- chunkname: @modules/configs/excel2json/lua_activity179_beat.lua

module("modules.configs.excel2json.lua_activity179_beat", package.seeall)

local lua_activity179_beat = {}
local fields = {
	targetId = 3,
	time = 6,
	noteGroupId = 4,
	id = 2,
	resouce = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity179_beat_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity179_beat, "configList", _configList)
	rawset(lua_activity179_beat, "configDict", _configDict)
end

setmetatable(lua_activity179_beat, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity179_beat.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity179_beat, "configList", nil)
	rawset(lua_activity179_beat, "configDict", nil)
end

return lua_activity179_beat
