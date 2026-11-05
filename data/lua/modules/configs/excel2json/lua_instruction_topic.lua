-- chunkname: @modules/configs/excel2json/lua_instruction_topic.lua

module("modules.configs.excel2json.lua_instruction_topic", package.seeall)

local lua_instruction_topic = {}
local fields = {
	id = 1,
	bonus = 3,
	spToastId = 4,
	chapterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.instruction_topic_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_instruction_topic, "configList", _configList)
	rawset(lua_instruction_topic, "configDict", _configDict)
end

setmetatable(lua_instruction_topic, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_instruction_topic.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_instruction_topic, "configList", nil)
	rawset(lua_instruction_topic, "configDict", nil)
end

return lua_instruction_topic
