-- chunkname: @modules/configs/excel2json/lua_bbs_main.lua

module("modules.configs.excel2json.lua_bbs_main", package.seeall)

local lua_bbs_main = {}
local fields = {
	decs = 7,
	name = 5,
	date = 6,
	type = 3,
	bbsName = 10,
	image = 8,
	citeStep = 9,
	ipAdress = 11,
	trigger = 12,
	triggerDecs = 13,
	id = 1,
	activityId = 2,
	step = 4
}
local primaryKey = {
	"id",
	"activityId",
	"step"
}
local mlStringKey = {
	triggerDecs = 5,
	name = 1,
	date = 2,
	bbsName = 4,
	decs = 3
}
local _configList, _configDict
local configPath = "configs.bbs_main_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bbs_main, "configList", _configList)
	rawset(lua_bbs_main, "configDict", _configDict)
end

setmetatable(lua_bbs_main, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bbs_main.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bbs_main, "configList", nil)
	rawset(lua_bbs_main, "configDict", nil)
end

return lua_bbs_main
