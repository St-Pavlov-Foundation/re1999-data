-- chunkname: @modules/configs/excel2json/lua_auto_chess_master.lua

module("modules.configs.excel2json.lua_auto_chess_master", package.seeall)

local lua_auto_chess_master = {}
local fields = {
	unlockSkill = 8,
	name = 2,
	spUdimoGoodsId = 19,
	isSelf = 4,
	udimoCase = 17,
	skillIcon = 13,
	spUdimo = 18,
	totalTriggerCountLimit = 11,
	skillId = 9,
	skillName = 12,
	skillDesc = 14,
	skillLockDesc = 16,
	roundTriggerCountLimit = 10,
	illustrationShow = 3,
	image = 7,
	isSpMaster = 5,
	hp = 6,
	skillProgressDesc = 15,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillProgressDesc = 4,
	skillName = 2,
	skillDesc = 3,
	skillLockDesc = 5
}
local _configList, _configDict
local configPath = "configs.auto_chess_master_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_master, "configList", _configList)
	rawset(lua_auto_chess_master, "configDict", _configDict)
end

setmetatable(lua_auto_chess_master, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_master.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_master, "configList", nil)
	rawset(lua_auto_chess_master, "configDict", nil)
end

return lua_auto_chess_master
