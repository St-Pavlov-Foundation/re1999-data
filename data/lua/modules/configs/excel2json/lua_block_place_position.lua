-- chunkname: @modules/configs/excel2json/lua_block_place_position.lua

module("modules.configs.excel2json.lua_block_place_position", package.seeall)

local lua_block_place_position = {}
local fields = {
	id = 1,
	z = 4,
	x = 2,
	y = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.block_place_position_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_block_place_position, "configList", _configList)
	rawset(lua_block_place_position, "configDict", _configDict)
end

setmetatable(lua_block_place_position, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_place_position.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_place_position, "configList", nil)
	rawset(lua_block_place_position, "configDict", nil)
end

return lua_block_place_position
