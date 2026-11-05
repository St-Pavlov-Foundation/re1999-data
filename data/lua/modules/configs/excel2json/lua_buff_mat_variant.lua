-- chunkname: @modules/configs/excel2json/lua_buff_mat_variant.lua

module("modules.configs.excel2json.lua_buff_mat_variant", package.seeall)

local lua_buff_mat_variant = {}
local fields = {
	id = 1,
	variant = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.buff_mat_variant_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_buff_mat_variant, "configList", _configList)
	rawset(lua_buff_mat_variant, "configDict", _configDict)
end

setmetatable(lua_buff_mat_variant, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_buff_mat_variant.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_buff_mat_variant, "configList", nil)
	rawset(lua_buff_mat_variant, "configDict", nil)
end

return lua_buff_mat_variant
