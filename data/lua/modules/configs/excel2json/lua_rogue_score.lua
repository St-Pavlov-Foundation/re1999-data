-- chunkname: @modules/configs/excel2json/lua_rogue_score.lua

module("modules.configs.excel2json.lua_rogue_score", package.seeall)

local lua_rogue_score = {}
local fields = {
	reward = 3,
	score = 2,
	special = 5,
	id = 1,
	stage = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_score, "configList", _configList)
	rawset(lua_rogue_score, "configDict", _configDict)
end

setmetatable(lua_rogue_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_score, "configList", nil)
	rawset(lua_rogue_score, "configDict", nil)
end

return lua_rogue_score
