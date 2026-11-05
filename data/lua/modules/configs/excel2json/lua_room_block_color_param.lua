-- chunkname: @modules/configs/excel2json/lua_room_block_color_param.lua

module("modules.configs.excel2json.lua_room_block_color_param", package.seeall)

local lua_room_block_color_param = {}
local fields = {
	id = 1,
	saturation = 3,
	brightness = 4,
	hue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_block_color_param_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_room_block_color_param.json_parse(config)

	rawset(lua_room_block_color_param, "configList", _configList)
	rawset(lua_room_block_color_param, "configDict", _configDict)
end

setmetatable(lua_room_block_color_param, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_block_color_param.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_block_color_param, "configList", nil)
	rawset(lua_room_block_color_param, "configDict", nil)
end

function lua_room_block_color_param.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		configDict[cfg.id] = cfg
	end

	return configList, configDict
end

return lua_room_block_color_param
