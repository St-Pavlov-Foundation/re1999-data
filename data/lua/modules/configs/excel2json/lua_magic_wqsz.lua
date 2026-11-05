-- chunkname: @modules/configs/excel2json/lua_magic_wqsz.lua

module("modules.configs.excel2json.lua_magic_wqsz", package.seeall)

local lua_magic_wqsz = {}
local fields = {
	id = 1,
	group = 3,
	returnLevel = 4,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.magic_wqsz_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_magic_wqsz, "configList", _configList)
	rawset(lua_magic_wqsz, "configDict", _configDict)
end

setmetatable(lua_magic_wqsz, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_magic_wqsz.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_magic_wqsz, "configList", nil)
	rawset(lua_magic_wqsz, "configDict", nil)
end

return lua_magic_wqsz
