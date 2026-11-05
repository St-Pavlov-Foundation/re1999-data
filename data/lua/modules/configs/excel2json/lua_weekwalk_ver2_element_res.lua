-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_element_res.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_element_res", package.seeall)

local lua_weekwalk_ver2_element_res = {}
local fields = {
	id = 1,
	res = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_ver2_element_res_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_ver2_element_res, "configList", _configList)
	rawset(lua_weekwalk_ver2_element_res, "configDict", _configDict)
end

setmetatable(lua_weekwalk_ver2_element_res, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_ver2_element_res.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_ver2_element_res, "configList", nil)
	rawset(lua_weekwalk_ver2_element_res, "configDict", nil)
end

return lua_weekwalk_ver2_element_res
