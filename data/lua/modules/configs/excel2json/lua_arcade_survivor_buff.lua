-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_buff.lua

module("modules.configs.excel2json.lua_arcade_survivor_buff", package.seeall)

local lua_arcade_survivor_buff = {}
local fields = {
	param = 5,
	name = 2,
	maxStack = 6,
	type = 4,
	levelKeep = 11,
	gainShow = 9,
	desc = 3,
	loopShow = 10,
	id = 1,
	duration = 8,
	isSubStack = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_buff, "configList", _configList)
	rawset(lua_arcade_survivor_buff, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_buff, "configList", nil)
	rawset(lua_arcade_survivor_buff, "configDict", nil)
end

return lua_arcade_survivor_buff
