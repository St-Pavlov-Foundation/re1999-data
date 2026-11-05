-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_reward.lua

module("modules.configs.excel2json.lua_v3a2_chapter_reward", package.seeall)

local lua_v3a2_chapter_reward = {}
local fields = {
	id = 1,
	reward = 3,
	count = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v3a2_chapter_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a2_chapter_reward, "configList", _configList)
	rawset(lua_v3a2_chapter_reward, "configDict", _configDict)
end

setmetatable(lua_v3a2_chapter_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a2_chapter_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a2_chapter_reward, "configList", nil)
	rawset(lua_v3a2_chapter_reward, "configDict", nil)
end

return lua_v3a2_chapter_reward
