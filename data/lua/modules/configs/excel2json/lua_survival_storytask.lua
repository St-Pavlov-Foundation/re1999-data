-- chunkname: @modules/configs/excel2json/lua_survival_storytask.lua

module("modules.configs.excel2json.lua_survival_storytask", package.seeall)

local lua_survival_storytask = {}
local fields = {
	id = 1,
	failCondition = 14,
	prepose = 13,
	dropShow = 17,
	desc4 = 9,
	title = 4,
	desc3 = 8,
	desc = 6,
	desc2 = 7,
	needAccept = 12,
	eventID = 5,
	maxProgress = 11,
	group = 2,
	progressCondition = 10,
	track = 18,
	uselessCondition = 15,
	autoDrop = 16,
	step = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc3 = 4,
	desc2 = 3,
	desc4 = 5,
	title = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.survival_storytask_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_storytask, "configList", _configList)
	rawset(lua_survival_storytask, "configDict", _configDict)
end

setmetatable(lua_survival_storytask, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_storytask.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_storytask, "configList", nil)
	rawset(lua_survival_storytask, "configDict", nil)
end

return lua_survival_storytask
