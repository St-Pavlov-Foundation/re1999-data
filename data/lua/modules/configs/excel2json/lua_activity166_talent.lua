-- chunkname: @modules/configs/excel2json/lua_activity166_talent.lua

module("modules.configs.excel2json.lua_activity166_talent", package.seeall)

local lua_activity166_talent = {}
local fields = {
	activityId = 1,
	name = 3,
	baseSkillIds = 6,
	baseSkillIds2 = 7,
	sortIndex = 8,
	icon = 5,
	talentId = 2,
	nameEn = 4
}
local primaryKey = {
	"activityId",
	"talentId"
}
local mlStringKey = {
	nameEn = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity166_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_talent, "configList", _configList)
	rawset(lua_activity166_talent, "configDict", _configDict)
end

setmetatable(lua_activity166_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_talent, "configList", nil)
	rawset(lua_activity166_talent, "configDict", nil)
end

return lua_activity166_talent
