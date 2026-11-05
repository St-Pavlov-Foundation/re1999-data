-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall.lua

module("modules.configs.excel2json.lua_auto_chess_mall", package.seeall)

local lua_auto_chess_mall = {}
local fields = {
	groups = 5,
	capacity = 6,
	showLevel = 4,
	type = 2,
	id = 1,
	canRefresh = 7,
	round = 3,
	isFree = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_mall_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_mall, "configList", _configList)
	rawset(lua_auto_chess_mall, "configDict", _configDict)
end

setmetatable(lua_auto_chess_mall, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_mall.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_mall, "configList", nil)
	rawset(lua_auto_chess_mall, "configDict", nil)
end

return lua_auto_chess_mall
