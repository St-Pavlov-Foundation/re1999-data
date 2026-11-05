-- chunkname: @modules/configs/excel2json/lua_formula_showtype.lua

module("modules.configs.excel2json.lua_formula_showtype", package.seeall)

local lua_formula_showtype = {}
local fields = {
	nameEn = 4,
	name = 3,
	id = 1,
	icon = 5,
	buildingType = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.formula_showtype_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_formula_showtype, "configList", _configList)
	rawset(lua_formula_showtype, "configDict", _configDict)
end

setmetatable(lua_formula_showtype, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_formula_showtype.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_formula_showtype, "configList", nil)
	rawset(lua_formula_showtype, "configDict", nil)
end

return lua_formula_showtype
