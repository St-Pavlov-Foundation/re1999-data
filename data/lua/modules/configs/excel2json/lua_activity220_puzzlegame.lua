-- chunkname: @modules/configs/excel2json/lua_activity220_puzzlegame.lua

module("modules.configs.excel2json.lua_activity220_puzzlegame", package.seeall)

local lua_activity220_puzzlegame = {}
local fields = {
	puzzleid = 2,
	fragment = 3,
	gameid = 1,
	targetPosition = 5,
	specialEnd = 8,
	bg = 6,
	initialPosition = 4,
	img = 7
}
local primaryKey = {
	"gameid",
	"puzzleid"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_puzzlegame_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_puzzlegame, "configList", _configList)
	rawset(lua_activity220_puzzlegame, "configDict", _configDict)
end

setmetatable(lua_activity220_puzzlegame, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_puzzlegame.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_puzzlegame, "configList", nil)
	rawset(lua_activity220_puzzlegame, "configDict", nil)
end

return lua_activity220_puzzlegame
