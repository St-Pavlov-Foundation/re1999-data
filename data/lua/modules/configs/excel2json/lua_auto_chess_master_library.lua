-- chunkname: @modules/configs/excel2json/lua_auto_chess_master_library.lua

module("modules.configs.excel2json.lua_auto_chess_master_library", package.seeall)

local lua_auto_chess_master_library = {}
local fields = {
	id = 1,
	masterId = 2,
	weight = 4,
	cardpackId = 3
}
local primaryKey = {
	"id",
	"masterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_master_library_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_master_library, "configList", _configList)
	rawset(lua_auto_chess_master_library, "configDict", _configDict)
end

setmetatable(lua_auto_chess_master_library, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_master_library.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_master_library, "configList", nil)
	rawset(lua_auto_chess_master_library, "configDict", nil)
end

return lua_auto_chess_master_library
