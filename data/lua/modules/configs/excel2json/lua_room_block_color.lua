-- chunkname: @modules/configs/excel2json/lua_room_block_color.lua

module("modules.configs.excel2json.lua_room_block_color", package.seeall)

local lua_room_block_color = {}
local fields = {
	voucherId = 3,
	blockId = 2,
	blockColor = 1
}
local primaryKey = {
	"blockColor"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_block_color_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_block_color, "configList", _configList)
	rawset(lua_room_block_color, "configDict", _configDict)
end

setmetatable(lua_room_block_color, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_block_color.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_block_color, "configList", nil)
	rawset(lua_room_block_color, "configDict", nil)
end

return lua_room_block_color
