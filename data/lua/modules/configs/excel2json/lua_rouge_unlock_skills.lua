-- chunkname: @modules/configs/excel2json/lua_rouge_unlock_skills.lua

module("modules.configs.excel2json.lua_rouge_unlock_skills", package.seeall)

local lua_rouge_unlock_skills = {}
local fields = {
	unlockEmblem = 5,
	style = 2,
	type = 4,
	skillId = 1,
	version = 3
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_unlock_skills_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_unlock_skills, "configList", _configList)
	rawset(lua_rouge_unlock_skills, "configDict", _configDict)
end

setmetatable(lua_rouge_unlock_skills, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_unlock_skills.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_unlock_skills, "configList", nil)
	rawset(lua_rouge_unlock_skills, "configDict", nil)
end

return lua_rouge_unlock_skills
