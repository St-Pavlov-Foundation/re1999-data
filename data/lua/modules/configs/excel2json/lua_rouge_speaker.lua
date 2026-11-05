-- chunkname: @modules/configs/excel2json/lua_rouge_speaker.lua

module("modules.configs.excel2json.lua_rouge_speaker", package.seeall)

local lua_rouge_speaker = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	nameIcon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	icon = 2,
	name = 1,
	nameIcon = 3
}
local _configList, _configDict
local configPath = "configs.rouge_speaker_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_speaker, "configList", _configList)
	rawset(lua_rouge_speaker, "configDict", _configDict)
end

setmetatable(lua_rouge_speaker, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_speaker.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_speaker, "configList", nil)
	rawset(lua_rouge_speaker, "configDict", nil)
end

return lua_rouge_speaker
