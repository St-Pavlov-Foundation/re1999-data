-- chunkname: @modules/configs/excel2json/lua_survival_maptarget.lua

module("modules.configs.excel2json.lua_survival_maptarget", package.seeall)

local lua_survival_maptarget = {}
local fields = {
	desc = 4,
	failCondition = 12,
	prepose = 11,
	dropShow = 15,
	group = 2,
	progressCondition = 8,
	uselessCondition = 13,
	showInExplore = 7,
	track = 16,
	desc2 = 6,
	needAccept = 10,
	maxProgress = 9,
	id = 1,
	icon = 5,
	autoDrop = 14,
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
local configPath = "configs.survival_maptarget_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_maptarget, "configList", _configList)
	rawset(lua_survival_maptarget, "configDict", _configDict)
end

setmetatable(lua_survival_maptarget, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_maptarget.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_maptarget, "configList", nil)
	rawset(lua_survival_maptarget, "configDict", nil)
end

return lua_survival_maptarget
