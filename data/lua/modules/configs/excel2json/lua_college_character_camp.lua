-- chunkname: @modules/configs/excel2json/lua_college_character_camp.lua

module("modules.configs.excel2json.lua_college_character_camp", package.seeall)

local lua_college_character_camp = {}
local fields = {
	text = 5,
	camp = 2,
	unlockId = 6,
	location = 3,
	id = 1,
	textId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 2,
	camp = 1
}
local _configList, _configDict
local configPath = "configs.college_character_camp_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_character_camp, "configList", _configList)
	rawset(lua_college_character_camp, "configDict", _configDict)
end

setmetatable(lua_college_character_camp, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_character_camp.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_character_camp, "configList", nil)
	rawset(lua_college_character_camp, "configDict", nil)
end

return lua_college_character_camp
