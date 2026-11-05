-- chunkname: @modules/configs/excel2json/lua_survival_role.lua

module("modules.configs.excel2json.lua_survival_role", package.seeall)

local lua_survival_role = {}
local fields = {
	initDisposition = 3,
	name = 2,
	skill = 17,
	isonline = 19,
	pic = 9,
	desc = 6,
	techSpriteId = 13,
	moveHead = 11,
	conditions = 15,
	mapHead = 12,
	initTalentIds = 18,
	chessPic = 8,
	dispositionType = 4,
	conditionsDesc = 16,
	resource = 7,
	head = 10,
	talentName = 5,
	id = 1,
	techIconType = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	talentName = 2,
	name = 1,
	conditionsDesc = 4,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.survival_role_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_role, "configList", _configList)
	rawset(lua_survival_role, "configDict", _configDict)
end

setmetatable(lua_survival_role, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_role.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_role, "configList", nil)
	rawset(lua_survival_role, "configDict", nil)
end

return lua_survival_role
