-- chunkname: @modules/configs/excel2json/lua_rouge_open.lua

module("modules.configs.excel2json.lua_rouge_open", package.seeall)

local lua_rouge_open = {}
local fields = {
	id = 1,
	name = 2,
	version = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_open_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_open, "configList", _configList)
	rawset(lua_rouge_open, "configDict", _configDict)
end

setmetatable(lua_rouge_open, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_open.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_open, "configList", nil)
	rawset(lua_rouge_open, "configDict", nil)
end

return lua_rouge_open
