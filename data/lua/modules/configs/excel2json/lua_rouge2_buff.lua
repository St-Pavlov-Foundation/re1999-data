-- chunkname: @modules/configs/excel2json/lua_rouge2_buff.lua

module("modules.configs.excel2json.lua_rouge2_buff", package.seeall)

local lua_rouge2_buff = {}
local fields = {
	battleTag = 10,
	name = 2,
	isOff = 3,
	outUnlock = 5,
	isHide = 7,
	isAttrBuff = 11,
	career = 15,
	unlock = 16,
	updateId = 19,
	descSimply = 18,
	desc = 17,
	passiveSkillId = 8,
	tag = 12,
	icon = 13,
	attributeTag = 14,
	sortId = 4,
	outUnlockDesc = 6,
	system = 21,
	descUpdate = 20,
	rare = 9,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	descSimply = 4,
	outUnlockDesc = 2,
	descUpdate = 5,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.rouge2_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_buff, "configList", _configList)
	rawset(lua_rouge2_buff, "configDict", _configDict)
end

setmetatable(lua_rouge2_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_buff, "configList", nil)
	rawset(lua_rouge2_buff, "configDict", nil)
end

return lua_rouge2_buff
