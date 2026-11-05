-- chunkname: @modules/configs/excel2json/lua_skill_bufftype.lua

module("modules.configs.excel2json.lua_skill_bufftype", package.seeall)

local lua_skill_bufftype = {}
local fields = {
	removeNum = 10,
	skipDelay = 11,
	dontShowFloat = 9,
	type = 2,
	includeTypes = 4,
	takeStage = 6,
	cannotRemove = 8,
	excludeTypes = 5,
	sortPriority = 15,
	takeAct = 7,
	matSort = 12,
	aniSort = 13,
	id = 1,
	playEffect = 14,
	group = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skill_bufftype_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_bufftype, "configList", _configList)
	rawset(lua_skill_bufftype, "configDict", _configDict)
end

setmetatable(lua_skill_bufftype, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_bufftype.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_bufftype, "configList", nil)
	rawset(lua_skill_bufftype, "configDict", nil)
end

return lua_skill_bufftype
