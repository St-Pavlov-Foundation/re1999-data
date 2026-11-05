-- chunkname: @modules/configs/excel2json/lua_rouge_quality.lua

module("modules.configs.excel2json.lua_rouge_quality", package.seeall)

local lua_rouge_quality = {}
local fields = {
	id = 1,
	name = 2,
	rareColor = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_quality_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_quality, "configList", _configList)
	rawset(lua_rouge_quality, "configDict", _configDict)
end

setmetatable(lua_rouge_quality, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_quality.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_quality, "configList", nil)
	rawset(lua_rouge_quality, "configDict", nil)
end

return lua_rouge_quality
