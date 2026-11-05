-- chunkname: @modules/configs/excel2json/lua_rouge_genius.lua

module("modules.configs.excel2json.lua_rouge_genius", package.seeall)

local lua_rouge_genius = {}
local fields = {
	cost = 6,
	name = 3,
	id = 2,
	season = 1,
	icon = 4,
	desc = 5
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_genius_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_genius, "configList", _configList)
	rawset(lua_rouge_genius, "configDict", _configDict)
end

setmetatable(lua_rouge_genius, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_genius.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_genius, "configList", nil)
	rawset(lua_rouge_genius, "configDict", nil)
end

return lua_rouge_genius
