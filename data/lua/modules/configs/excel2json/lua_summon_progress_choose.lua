-- chunkname: @modules/configs/excel2json/lua_summon_progress_choose.lua

module("modules.configs.excel2json.lua_summon_progress_choose", package.seeall)

local lua_summon_progress_choose = {}
local fields = {
	groupId = 1,
	chooseRewards = 3,
	progress = 2
}
local primaryKey = {
	"groupId",
	"progress"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_progress_choose_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_progress_choose, "configList", _configList)
	rawset(lua_summon_progress_choose, "configDict", _configDict)
end

setmetatable(lua_summon_progress_choose, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_progress_choose.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_progress_choose, "configList", nil)
	rawset(lua_summon_progress_choose, "configDict", nil)
end

return lua_summon_progress_choose
