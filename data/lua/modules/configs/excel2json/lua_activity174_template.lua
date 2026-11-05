-- chunkname: @modules/configs/excel2json/lua_activity174_template.lua

module("modules.configs.excel2json.lua_activity174_template", package.seeall)

local lua_activity174_template = {}
local fields = {
	defense = 4,
	id = 1,
	technic = 6,
	life = 2,
	attack = 3,
	mdefense = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_template_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_template, "configList", _configList)
	rawset(lua_activity174_template, "configDict", _configDict)
end

setmetatable(lua_activity174_template, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_template.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_template, "configList", nil)
	rawset(lua_activity174_template, "configDict", nil)
end

return lua_activity174_template
