-- chunkname: @modules/configs/excel2json/lua_rouge2_team_feature.lua

module("modules.configs.excel2json.lua_rouge2_team_feature", package.seeall)

local lua_rouge2_team_feature = {}
local fields = {
	id = 1,
	name = 2,
	skill = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_team_feature_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_team_feature, "configList", _configList)
	rawset(lua_rouge2_team_feature, "configDict", _configDict)
end

setmetatable(lua_rouge2_team_feature, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_team_feature.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_team_feature, "configList", nil)
	rawset(lua_rouge2_team_feature, "configDict", nil)
end

return lua_rouge2_team_feature
