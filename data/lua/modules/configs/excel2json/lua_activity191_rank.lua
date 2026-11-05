-- chunkname: @modules/configs/excel2json/lua_activity191_rank.lua

module("modules.configs.excel2json.lua_activity191_rank", package.seeall)

local lua_activity191_rank = {}
local fields = {
	rank = 1,
	fightLevel = 2
}
local primaryKey = {
	"rank"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_rank_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_rank, "configList", _configList)
	rawset(lua_activity191_rank, "configDict", _configDict)
end

setmetatable(lua_activity191_rank, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_rank.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_rank, "configList", nil)
	rawset(lua_activity191_rank, "configDict", nil)
end

return lua_activity191_rank
