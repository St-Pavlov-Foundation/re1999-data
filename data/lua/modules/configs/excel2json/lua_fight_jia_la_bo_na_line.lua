-- chunkname: @modules/configs/excel2json/lua_fight_jia_la_bo_na_line.lua

module("modules.configs.excel2json.lua_fight_jia_la_bo_na_line", package.seeall)

local lua_fight_jia_la_bo_na_line = {}
local fields = {
	id = 1,
	lineEffect = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_jia_la_bo_na_line_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_jia_la_bo_na_line, "configList", _configList)
	rawset(lua_fight_jia_la_bo_na_line, "configDict", _configDict)
end

setmetatable(lua_fight_jia_la_bo_na_line, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_jia_la_bo_na_line.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_jia_la_bo_na_line, "configList", nil)
	rawset(lua_fight_jia_la_bo_na_line, "configDict", nil)
end

return lua_fight_jia_la_bo_na_line
