-- chunkname: @modules/configs/excel2json/lua_investigate_info.lua

module("modules.configs.excel2json.lua_investigate_info", package.seeall)

local lua_investigate_info = {}
local fields = {
	icon = 6,
	name = 5,
	conclusionDesc = 11,
	conclusionBg = 10,
	group = 3,
	unlockDesc = 7,
	episode = 2,
	desc = 8,
	clueNumber = 9,
	id = 1,
	entrance = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 2,
	name = 1,
	conclusionDesc = 4,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.investigate_info_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_investigate_info, "configList", _configList)
	rawset(lua_investigate_info, "configDict", _configDict)
end

setmetatable(lua_investigate_info, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_investigate_info.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_investigate_info, "configList", nil)
	rawset(lua_investigate_info, "configDict", nil)
end

return lua_investigate_info
