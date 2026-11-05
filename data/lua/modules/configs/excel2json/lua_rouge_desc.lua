-- chunkname: @modules/configs/excel2json/lua_rouge_desc.lua

module("modules.configs.excel2json.lua_rouge_desc", package.seeall)

local lua_rouge_desc = {}
local fields = {
	descExtra = 6,
	name = 2,
	descType = 5,
	effectId = 3,
	id = 1,
	descSimply = 7,
	descExtraSimply = 8,
	desc = 4
}
local primaryKey = {
	"id",
	"effectId"
}
local mlStringKey = {
	descExtra = 3,
	descSimply = 4,
	name = 1,
	descExtraSimply = 5,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_desc, "configList", _configList)
	rawset(lua_rouge_desc, "configDict", _configDict)
end

setmetatable(lua_rouge_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_desc, "configList", nil)
	rawset(lua_rouge_desc, "configDict", nil)
end

return lua_rouge_desc
