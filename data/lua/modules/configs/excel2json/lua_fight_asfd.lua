-- chunkname: @modules/configs/excel2json/lua_fight_asfd.lua

module("modules.configs.excel2json.lua_fight_asfd", package.seeall)

local lua_fight_asfd = {}
local fields = {
	replaceRule = 3,
	priority = 10,
	sampleMinHeight = 8,
	audio = 6,
	res = 4,
	sceneEmitterId = 5,
	id = 1,
	unit = 2,
	scale = 7,
	flyPath = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_asfd_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_asfd, "configList", _configList)
	rawset(lua_fight_asfd, "configDict", _configDict)
end

setmetatable(lua_fight_asfd, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_asfd.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_asfd, "configList", nil)
	rawset(lua_fight_asfd, "configDict", nil)
end

return lua_fight_asfd
