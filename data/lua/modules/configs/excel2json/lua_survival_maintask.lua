-- chunkname: @modules/configs/excel2json/lua_survival_maintask.lua

module("modules.configs.excel2json.lua_survival_maintask", package.seeall)

local lua_survival_maintask = {}
local fields = {
	versions = 5,
	failCondition = 13,
	prepose = 12,
	maintaskChange = 6,
	group = 2,
	progressCondition = 9,
	autoDrop = 14,
	desc = 7,
	dropShow = 15,
	desc2 = 8,
	needAccept = 11,
	seasons = 4,
	id = 1,
	maxProgress = 10,
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
local configPath = "configs.survival_maintask_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_maintask, "configList", _configList)
	rawset(lua_survival_maintask, "configDict", _configDict)
end

setmetatable(lua_survival_maintask, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_maintask.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_maintask, "configList", nil)
	rawset(lua_survival_maintask, "configDict", nil)
end

return lua_survival_maintask
