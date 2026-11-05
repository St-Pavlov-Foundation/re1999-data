-- chunkname: @modules/configs/excel2json/lua_stealth_technique.lua

module("modules.configs.excel2json.lua_stealth_technique", package.seeall)

local lua_stealth_technique = {}
local fields = {
	mainTitleId = 2,
	picture = 6,
	subTitle = 5,
	showInMap = 8,
	id = 1,
	mainTitle = 4,
	content = 7,
	subTitleId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 3,
	mainTitle = 1,
	subTitle = 2
}
local _configList, _configDict
local configPath = "configs.stealth_technique_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stealth_technique, "configList", _configList)
	rawset(lua_stealth_technique, "configDict", _configDict)
end

setmetatable(lua_stealth_technique, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stealth_technique.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stealth_technique, "configList", nil)
	rawset(lua_stealth_technique, "configDict", nil)
end

return lua_stealth_technique
