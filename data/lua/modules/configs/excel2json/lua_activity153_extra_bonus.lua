-- chunkname: @modules/configs/excel2json/lua_activity153_extra_bonus.lua

module("modules.configs.excel2json.lua_activity153_extra_bonus", package.seeall)

local lua_activity153_extra_bonus = {}
local fields = {
	chapterId = 3,
	extraBonus = 4,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity153_extra_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity153_extra_bonus, "configList", _configList)
	rawset(lua_activity153_extra_bonus, "configDict", _configDict)
end

setmetatable(lua_activity153_extra_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity153_extra_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity153_extra_bonus, "configList", nil)
	rawset(lua_activity153_extra_bonus, "configDict", nil)
end

return lua_activity153_extra_bonus
