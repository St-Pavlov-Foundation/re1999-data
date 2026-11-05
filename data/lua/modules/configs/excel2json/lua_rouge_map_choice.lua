-- chunkname: @modules/configs/excel2json/lua_rouge_map_choice.lua

module("modules.configs.excel2json.lua_rouge_map_choice", package.seeall)

local lua_rouge_map_choice = {}
local fields = {
	groupId = 2,
	layerId = 1,
	dropId = 3
}
local primaryKey = {
	"layerId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_map_choice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_map_choice, "configList", _configList)
	rawset(lua_rouge_map_choice, "configDict", _configDict)
end

setmetatable(lua_rouge_map_choice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_map_choice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_map_choice, "configList", nil)
	rawset(lua_rouge_map_choice, "configDict", nil)
end

return lua_rouge_map_choice
