-- chunkname: @modules/configs/excel2json/lua_rouge_spcollection_desc.lua

module("modules.configs.excel2json.lua_rouge_spcollection_desc", package.seeall)

local lua_rouge_spcollection_desc = {}
local fields = {
	descSimply = 6,
	conditionSimply = 5,
	effectId = 2,
	id = 1,
	condition = 3,
	desc = 4
}
local primaryKey = {
	"id",
	"effectId"
}
local mlStringKey = {
	conditionSimply = 3,
	descSimply = 4,
	condition = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge_spcollection_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_spcollection_desc, "configList", _configList)
	rawset(lua_rouge_spcollection_desc, "configDict", _configDict)
end

setmetatable(lua_rouge_spcollection_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_spcollection_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_spcollection_desc, "configList", nil)
	rawset(lua_rouge_spcollection_desc, "configDict", nil)
end

return lua_rouge_spcollection_desc
