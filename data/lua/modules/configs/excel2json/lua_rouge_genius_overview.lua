-- chunkname: @modules/configs/excel2json/lua_rouge_genius_overview.lua

module("modules.configs.excel2json.lua_rouge_genius_overview", package.seeall)

local lua_rouge_genius_overview = {}
local fields = {
	name = 2,
	ismul = 4,
	id = 1,
	value = 3,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_genius_overview_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_genius_overview, "configList", _configList)
	rawset(lua_rouge_genius_overview, "configDict", _configDict)
end

setmetatable(lua_rouge_genius_overview, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_genius_overview.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_genius_overview, "configList", nil)
	rawset(lua_rouge_genius_overview, "configDict", nil)
end

return lua_rouge_genius_overview
