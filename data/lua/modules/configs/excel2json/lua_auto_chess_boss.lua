-- chunkname: @modules/configs/excel2json/lua_auto_chess_boss.lua

module("modules.configs.excel2json.lua_auto_chess_boss", package.seeall)

local lua_auto_chess_boss = {}
local fields = {
	expBonus = 2,
	startBtnImage = 6,
	loadingImage = 5,
	id = 1,
	collectionBonus = 3,
	smallImage = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_boss_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_boss, "configList", _configList)
	rawset(lua_auto_chess_boss, "configDict", _configDict)
end

setmetatable(lua_auto_chess_boss, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_boss.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_boss, "configList", nil)
	rawset(lua_auto_chess_boss, "configDict", nil)
end

return lua_auto_chess_boss
