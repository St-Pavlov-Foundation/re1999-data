-- chunkname: @modules/configs/excel2json/lua_character_talent.lua

module("modules.configs.excel2json.lua_character_talent", package.seeall)

local lua_character_talent = {}
local fields = {
	requirement = 5,
	heroId = 1,
	consume = 6,
	exclusive = 4,
	talentMould = 3,
	talentId = 2
}
local primaryKey = {
	"heroId",
	"talentId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_talent, "configList", _configList)
	rawset(lua_character_talent, "configDict", _configDict)
end

setmetatable(lua_character_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_talent, "configList", nil)
	rawset(lua_character_talent, "configDict", nil)
end

return lua_character_talent
