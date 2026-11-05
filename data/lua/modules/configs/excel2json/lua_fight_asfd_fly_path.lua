-- chunkname: @modules/configs/excel2json/lua_fight_asfd_fly_path.lua

module("modules.configs.excel2json.lua_fight_asfd_fly_path", package.seeall)

local lua_fight_asfd_fly_path = {}
local fields = {
	flyDuration = 2,
	id = 1,
	lineType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_asfd_fly_path_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_asfd_fly_path, "configList", _configList)
	rawset(lua_fight_asfd_fly_path, "configDict", _configDict)
end

setmetatable(lua_fight_asfd_fly_path, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_asfd_fly_path.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_asfd_fly_path, "configList", nil)
	rawset(lua_fight_asfd_fly_path, "configDict", nil)
end

return lua_fight_asfd_fly_path
