-- chunkname: @modules/configs/excel2json/lua_rouge_talent.lua

module("modules.configs.excel2json.lua_rouge_talent", package.seeall)

local lua_rouge_talent = {}
local fields = {
	cost = 5,
	name = 2,
	id = 1,
	icon = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_talent, "configList", _configList)
	rawset(lua_rouge_talent, "configDict", _configDict)
end

setmetatable(lua_rouge_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_talent, "configList", nil)
	rawset(lua_rouge_talent, "configDict", nil)
end

return lua_rouge_talent
