-- chunkname: @modules/configs/excel2json/lua_auto_chess_master_skill.lua

module("modules.configs.excel2json.lua_auto_chess_master_skill", package.seeall)

local lua_auto_chess_master_skill = {}
local fields = {
	cost = 2,
	abilities = 6,
	targetType = 11,
	activeChessSkill = 5,
	passiveChessSkills = 4,
	skillIndex = 9,
	type = 3,
	skillaction = 7,
	useeffect = 8,
	id = 1,
	needTarget = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_master_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_master_skill, "configList", _configList)
	rawset(lua_auto_chess_master_skill, "configDict", _configDict)
end

setmetatable(lua_auto_chess_master_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_master_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_master_skill, "configList", nil)
	rawset(lua_auto_chess_master_skill, "configDict", nil)
end

return lua_auto_chess_master_skill
