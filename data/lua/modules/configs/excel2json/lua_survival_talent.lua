-- chunkname: @modules/configs/excel2json/lua_survival_talent.lua

module("modules.configs.excel2json.lua_survival_talent", package.seeall)

local lua_survival_talent = {}
local fields = {
	versions = 3,
	name = 5,
	groupId = 2,
	seasons = 4,
	id = 1,
	desc1 = 6,
	desc2 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.survival_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_talent, "configList", _configList)
	rawset(lua_survival_talent, "configDict", _configDict)
end

setmetatable(lua_survival_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_talent, "configList", nil)
	rawset(lua_survival_talent, "configDict", nil)
end

return lua_survival_talent
