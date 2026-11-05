-- chunkname: @modules/configs/excel2json/lua_fight_lzl_buff_float.lua

module("modules.configs.excel2json.lua_fight_lzl_buff_float", package.seeall)

local lua_fight_lzl_buff_float = {}
local fields = {
	effectRoot = 5,
	effect = 4,
	effectAudio = 6,
	skinId = 3,
	id = 1,
	duration = 7,
	layer = 2
}
local primaryKey = {
	"id",
	"layer",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_lzl_buff_float_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_lzl_buff_float, "configList", _configList)
	rawset(lua_fight_lzl_buff_float, "configDict", _configDict)
end

setmetatable(lua_fight_lzl_buff_float, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_lzl_buff_float.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_lzl_buff_float, "configList", nil)
	rawset(lua_fight_lzl_buff_float, "configDict", nil)
end

return lua_fight_lzl_buff_float
