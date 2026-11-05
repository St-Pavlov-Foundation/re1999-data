-- chunkname: @modules/configs/excel2json/lua_fight_stacked_buff_combine.lua

module("modules.configs.excel2json.lua_fight_stacked_buff_combine", package.seeall)

local lua_fight_stacked_buff_combine = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_stacked_buff_combine_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_stacked_buff_combine, "configList", _configList)
	rawset(lua_fight_stacked_buff_combine, "configDict", _configDict)
end

setmetatable(lua_fight_stacked_buff_combine, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_stacked_buff_combine.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_stacked_buff_combine, "configList", nil)
	rawset(lua_fight_stacked_buff_combine, "configDict", nil)
end

return lua_fight_stacked_buff_combine
