-- chunkname: @modules/configs/excel2json/lua_rouge2_quality.lua

module("modules.configs.excel2json.lua_rouge2_quality", package.seeall)

local lua_rouge2_quality = {}
local fields = {
	relicsColor = 5,
	name = 2,
	buffColor = 4,
	id = 1,
	rareColor = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_quality_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_quality, "configList", _configList)
	rawset(lua_rouge2_quality, "configDict", _configDict)
end

setmetatable(lua_rouge2_quality, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_quality.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_quality, "configList", nil)
	rawset(lua_rouge2_quality, "configDict", nil)
end

return lua_rouge2_quality
