-- chunkname: @modules/configs/excel2json/lua_skill.lua

module("modules.configs.excel2json.lua_skill", package.seeall)

local lua_skill = {}
local fields = {
	icon = 4,
	name = 2,
	desc_art = 5,
	timeline = 3,
	preFxId = 14,
	notDoAction = 10,
	bloomParams = 12,
	activeTargetFrameEvent = 13,
	eff_desc = 6,
	heroId = 15,
	battleTag = 7,
	id = 1,
	skillEffect = 8,
	showInBattle = 11,
	skillRank = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc_art = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill, "configList", _configList)
	rawset(lua_skill, "configDict", _configDict)
end

setmetatable(lua_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill, "configList", nil)
	rawset(lua_skill, "configDict", nil)
end

return lua_skill
