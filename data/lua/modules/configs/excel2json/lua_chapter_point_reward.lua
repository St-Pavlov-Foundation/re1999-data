-- chunkname: @modules/configs/excel2json/lua_chapter_point_reward.lua

module("modules.configs.excel2json.lua_chapter_point_reward", package.seeall)

local lua_chapter_point_reward = {}
local fields = {
	reward = 4,
	display = 6,
	unlockChapter = 5,
	chapterId = 2,
	id = 1,
	rewardPointNum = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.chapter_point_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_point_reward, "configList", _configList)
	rawset(lua_chapter_point_reward, "configDict", _configDict)
end

setmetatable(lua_chapter_point_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_point_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_point_reward, "configList", nil)
	rawset(lua_chapter_point_reward, "configDict", nil)
end

return lua_chapter_point_reward
