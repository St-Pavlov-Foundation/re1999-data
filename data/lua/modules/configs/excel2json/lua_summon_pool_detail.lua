-- chunkname: @modules/configs/excel2json/lua_summon_pool_detail.lua

module("modules.configs.excel2json.lua_summon_pool_detail", package.seeall)

local lua_summon_pool_detail = {}
local fields = {
	order = 6,
	name = 4,
	openId = 7,
	historyShowType = 5,
	id = 1,
	info = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.summon_pool_detail_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_pool_detail, "configList", _configList)
	rawset(lua_summon_pool_detail, "configDict", _configDict)
end

setmetatable(lua_summon_pool_detail, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_pool_detail.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_pool_detail, "configList", nil)
	rawset(lua_summon_pool_detail, "configDict", nil)
end

return lua_summon_pool_detail
