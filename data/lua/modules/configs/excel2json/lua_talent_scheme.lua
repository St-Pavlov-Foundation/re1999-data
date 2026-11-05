-- chunkname: @modules/configs/excel2json/lua_talent_scheme.lua

module("modules.configs.excel2json.lua_talent_scheme", package.seeall)

local lua_talent_scheme = {}
local fields = {
	talentMould = 2,
	starMould = 3,
	talentId = 1,
	talenScheme = 4
}
local primaryKey = {
	"talentId",
	"talentMould",
	"starMould"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.talent_scheme_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_scheme, "configList", _configList)
	rawset(lua_talent_scheme, "configDict", _configDict)
end

setmetatable(lua_talent_scheme, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_scheme.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_scheme, "configList", nil)
	rawset(lua_talent_scheme, "configDict", nil)
end

return lua_talent_scheme
