-- chunkname: @modules/configs/excel2json/lua_activity163_clue.lua

module("modules.configs.excel2json.lua_activity163_clue", package.seeall)

local lua_activity163_clue = {}
local fields = {
	clueName = 3,
	materialId = 6,
	clueIcon = 2,
	clueId = 1,
	clueDesc = 4,
	replaceId = 7,
	episodeId = 5
}
local primaryKey = {
	"clueId"
}
local mlStringKey = {
	clueName = 1,
	clueDesc = 2
}
local _configList, _configDict
local configPath = "configs.activity163_clue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity163_clue, "configList", _configList)
	rawset(lua_activity163_clue, "configDict", _configDict)
end

setmetatable(lua_activity163_clue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity163_clue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity163_clue, "configList", nil)
	rawset(lua_activity163_clue, "configDict", nil)
end

return lua_activity163_clue
