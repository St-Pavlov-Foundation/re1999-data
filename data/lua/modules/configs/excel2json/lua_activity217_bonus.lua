-- chunkname: @modules/configs/excel2json/lua_activity217_bonus.lua

module("modules.configs.excel2json.lua_activity217_bonus", package.seeall)

local lua_activity217_bonus = {}
local fields = {
	extraBonus = 5,
	chapterId = 3,
	episodeType = 4,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity217_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity217_bonus, "configList", _configList)
	rawset(lua_activity217_bonus, "configDict", _configDict)
end

setmetatable(lua_activity217_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity217_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity217_bonus, "configList", nil)
	rawset(lua_activity217_bonus, "configDict", nil)
end

return lua_activity217_bonus
