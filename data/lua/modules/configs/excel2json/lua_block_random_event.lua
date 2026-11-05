-- chunkname: @modules/configs/excel2json/lua_block_random_event.lua

module("modules.configs.excel2json.lua_block_random_event", package.seeall)

local lua_block_random_event = {}
local fields = {
	id = 1,
	blockCount = 2,
	event = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.block_random_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_block_random_event, "configList", _configList)
	rawset(lua_block_random_event, "configDict", _configDict)
end

setmetatable(lua_block_random_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_random_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_random_event, "configList", nil)
	rawset(lua_block_random_event, "configDict", nil)
end

return lua_block_random_event
