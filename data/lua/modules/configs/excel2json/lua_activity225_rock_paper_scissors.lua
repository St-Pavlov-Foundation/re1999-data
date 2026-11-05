-- chunkname: @modules/configs/excel2json/lua_activity225_rock_paper_scissors.lua

module("modules.configs.excel2json.lua_activity225_rock_paper_scissors", package.seeall)

local lua_activity225_rock_paper_scissors = {}
local fields = {
	winBonus = 3,
	loseBonus = 5,
	drawBonus = 4,
	activityId = 1,
	times = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity225_rock_paper_scissors_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_rock_paper_scissors, "configList", _configList)
	rawset(lua_activity225_rock_paper_scissors, "configDict", _configDict)
end

setmetatable(lua_activity225_rock_paper_scissors, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_rock_paper_scissors.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_rock_paper_scissors, "configList", nil)
	rawset(lua_activity225_rock_paper_scissors, "configDict", nil)
end

return lua_activity225_rock_paper_scissors
