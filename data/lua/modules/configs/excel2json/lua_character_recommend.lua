-- chunkname: @modules/configs/excel2json/lua_character_recommend.lua

module("modules.configs.excel2json.lua_character_recommend", package.seeall)

local lua_character_recommend = {}
local fields = {
	equipRec = 4,
	teamDisplay = 3,
	resonanceRec = 7,
	lvRec = 6,
	id = 1,
	equipDisplay = 5,
	teamRec = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_recommend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_recommend, "configList", _configList)
	rawset(lua_character_recommend, "configDict", _configDict)
end

setmetatable(lua_character_recommend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_recommend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_recommend, "configList", nil)
	rawset(lua_character_recommend, "configDict", nil)
end

return lua_character_recommend
