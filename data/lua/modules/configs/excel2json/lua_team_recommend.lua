-- chunkname: @modules/configs/excel2json/lua_team_recommend.lua

module("modules.configs.excel2json.lua_team_recommend", package.seeall)

local lua_team_recommend = {}
local fields = {
	pos3 = 5,
	pos1 = 3,
	pos2 = 4,
	teamName = 2,
	id = 1,
	pos4 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	teamName = 1
}
local _configList, _configDict
local configPath = "configs.team_recommend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_team_recommend, "configList", _configList)
	rawset(lua_team_recommend, "configDict", _configDict)
end

setmetatable(lua_team_recommend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_team_recommend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_team_recommend, "configList", nil)
	rawset(lua_team_recommend, "configDict", nil)
end

return lua_team_recommend
