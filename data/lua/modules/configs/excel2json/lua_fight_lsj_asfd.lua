-- chunkname: @modules/configs/excel2json/lua_fight_lsj_asfd.lua

module("modules.configs.excel2json.lua_fight_lsj_asfd", package.seeall)

local lua_fight_lsj_asfd = {}
local fields = {
	action = 5,
	missileDelay = 6,
	spineRes = 2,
	missileOffset = 7,
	index = 1,
	duration = 4,
	pos = 3
}
local primaryKey = {
	"index"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_lsj_asfd_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_lsj_asfd, "configList", _configList)
	rawset(lua_fight_lsj_asfd, "configDict", _configDict)
end

setmetatable(lua_fight_lsj_asfd, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_lsj_asfd.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_lsj_asfd, "configList", nil)
	rawset(lua_fight_lsj_asfd, "configDict", nil)
end

return lua_fight_lsj_asfd
