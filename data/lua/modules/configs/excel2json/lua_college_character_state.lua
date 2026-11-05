-- chunkname: @modules/configs/excel2json/lua_college_character_state.lua

module("modules.configs.excel2json.lua_college_character_state", package.seeall)

local lua_college_character_state = {}
local fields = {
	chaChange = 7,
	relationshipCha = 8,
	positionId = 4,
	state = 5,
	stateId = 1,
	relationshipTxt = 9,
	isClick = 6,
	relationshipType = 10,
	chaTxt = 11,
	chaId = 2,
	otherId = 3
}
local primaryKey = {
	"stateId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.college_character_state_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_character_state, "configList", _configList)
	rawset(lua_college_character_state, "configDict", _configDict)
end

setmetatable(lua_college_character_state, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_character_state.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_character_state, "configList", nil)
	rawset(lua_college_character_state, "configDict", nil)
end

return lua_college_character_state
