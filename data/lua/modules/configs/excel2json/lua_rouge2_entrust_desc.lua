-- chunkname: @modules/configs/excel2json/lua_rouge2_entrust_desc.lua

module("modules.configs.excel2json.lua_rouge2_entrust_desc", package.seeall)

local lua_rouge2_entrust_desc = {}
local fields = {
	id = 1,
	finishDesc = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	finishDesc = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_entrust_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_entrust_desc, "configList", _configList)
	rawset(lua_rouge2_entrust_desc, "configDict", _configDict)
end

setmetatable(lua_rouge2_entrust_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_entrust_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_entrust_desc, "configList", nil)
	rawset(lua_rouge2_entrust_desc, "configDict", nil)
end

return lua_rouge2_entrust_desc
