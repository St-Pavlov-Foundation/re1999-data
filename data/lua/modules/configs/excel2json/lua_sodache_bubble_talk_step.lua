-- chunkname: @modules/configs/excel2json/lua_sodache_bubble_talk_step.lua

module("modules.configs.excel2json.lua_sodache_bubble_talk_step", package.seeall)

local lua_sodache_bubble_talk_step = {}
local fields = {
	id = 1,
	content = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.sodache_bubble_talk_step_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_bubble_talk_step, "configList", _configList)
	rawset(lua_sodache_bubble_talk_step, "configDict", _configDict)
end

setmetatable(lua_sodache_bubble_talk_step, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_bubble_talk_step.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_bubble_talk_step, "configList", nil)
	rawset(lua_sodache_bubble_talk_step, "configDict", nil)
end

return lua_sodache_bubble_talk_step
