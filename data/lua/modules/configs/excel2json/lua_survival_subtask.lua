-- chunkname: @modules/configs/excel2json/lua_survival_subtask.lua

module("modules.configs.excel2json.lua_survival_subtask", package.seeall)

local lua_survival_subtask = {}
local fields = {
	jump = 17,
	failCondition = 14,
	maintaskChange = 7,
	dropShow = 16,
	prepose = 13,
	type = 4,
	autoDrop = 15,
	desc = 8,
	desc2 = 9,
	needAccept = 12,
	maxProgress = 11,
	versions = 6,
	group = 2,
	progressCondition = 10,
	seasons = 5,
	id = 1,
	step = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_subtask_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_subtask, "configList", _configList)
	rawset(lua_survival_subtask, "configDict", _configDict)
end

setmetatable(lua_survival_subtask, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_subtask.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_subtask, "configList", nil)
	rawset(lua_survival_subtask, "configDict", nil)
end

return lua_survival_subtask
