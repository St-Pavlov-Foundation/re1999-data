-- chunkname: @modules/configs/excel2json/lua_v3a8_warmup_play.lua

module("modules.configs.excel2json.lua_v3a8_warmup_play", package.seeall)

local lua_v3a8_warmup_play = {}
local fields = {
	issue = 3,
	op3 = 7,
	op2 = 6,
	answer = 4,
	op1 = 5,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	issue = 1,
	op1 = 2,
	op3 = 4,
	op2 = 3
}
local _configList, _configDict
local configPath = "configs.v3a8_warmup_play_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a8_warmup_play, "configList", _configList)
	rawset(lua_v3a8_warmup_play, "configDict", _configDict)
end

setmetatable(lua_v3a8_warmup_play, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a8_warmup_play.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a8_warmup_play, "configList", nil)
	rawset(lua_v3a8_warmup_play, "configDict", nil)
end

return lua_v3a8_warmup_play
