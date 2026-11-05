-- chunkname: @modules/configs/excel2json/lua_instruction_level.lua

module("modules.configs.excel2json.lua_instruction_level", package.seeall)

local lua_instruction_level = {}
local fields = {
	picRes = 7,
	desc = 6,
	topicId = 2,
	instructionDesc = 4,
	id = 1,
	desc_en = 5,
	preEpisode = 8,
	episodeId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	instructionDesc = 1
}
local _configList, _configDict
local configPath = "configs.instruction_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_instruction_level, "configList", _configList)
	rawset(lua_instruction_level, "configDict", _configDict)
end

setmetatable(lua_instruction_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_instruction_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_instruction_level, "configList", nil)
	rawset(lua_instruction_level, "configDict", nil)
end

return lua_instruction_level
