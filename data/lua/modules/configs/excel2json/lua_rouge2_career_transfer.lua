-- chunkname: @modules/configs/excel2json/lua_rouge2_career_transfer.lua

module("modules.configs.excel2json.lua_rouge2_career_transfer", package.seeall)

local lua_rouge2_career_transfer = {}
local fields = {
	recommendAttribute = 6,
	name = 3,
	passiveSkillBrief = 9,
	unlockParam = 13,
	healthLimit = 7,
	activeSkills = 11,
	career = 2,
	unlockType = 12,
	passiveSkills = 10,
	careerTransferDesc = 4,
	initialTreasure = 8,
	recommendTeam = 14,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	careerTransferDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_career_transfer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_career_transfer, "configList", _configList)
	rawset(lua_rouge2_career_transfer, "configDict", _configDict)
end

setmetatable(lua_rouge2_career_transfer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_career_transfer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_career_transfer, "configList", nil)
	rawset(lua_rouge2_career_transfer, "configDict", nil)
end

return lua_rouge2_career_transfer
