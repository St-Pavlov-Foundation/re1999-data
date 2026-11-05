-- chunkname: @modules/configs/excel2json/lua_partygame_answer_const.lua

module("modules.configs.excel2json.lua_partygame_answer_const", package.seeall)

local lua_partygame_answer_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_answer_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_answer_const, "configList", _configList)
	rawset(lua_partygame_answer_const, "configDict", _configDict)
end

setmetatable(lua_partygame_answer_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_answer_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_answer_const, "configList", nil)
	rawset(lua_partygame_answer_const, "configDict", nil)
end

return lua_partygame_answer_const
