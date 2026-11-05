-- chunkname: @modules/configs/excel2json/lua_rouge_style_talent.lua

module("modules.configs.excel2json.lua_rouge_style_talent", package.seeall)

local lua_rouge_style_talent = {}
local fields = {
	interactive = 4,
	unlockType = 8,
	desc = 7,
	type = 2,
	id = 1,
	version = 3,
	ban = 6,
	attribute = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_style_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_style_talent, "configList", _configList)
	rawset(lua_rouge_style_talent, "configDict", _configDict)
end

setmetatable(lua_rouge_style_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_style_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_style_talent, "configList", nil)
	rawset(lua_rouge_style_talent, "configDict", nil)
end

return lua_rouge_style_talent
