-- chunkname: @modules/configs/excel2json/lua_weekwalk_buff_pool.lua

module("modules.configs.excel2json.lua_weekwalk_buff_pool", package.seeall)

local lua_weekwalk_buff_pool = {}
local fields = {
	id = 1,
	buffId = 2
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_buff_pool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_buff_pool, "configList", _configList)
	rawset(lua_weekwalk_buff_pool, "configDict", _configDict)
end

setmetatable(lua_weekwalk_buff_pool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_buff_pool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_buff_pool, "configList", nil)
	rawset(lua_weekwalk_buff_pool, "configDict", nil)
end

return lua_weekwalk_buff_pool
