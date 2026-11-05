-- chunkname: @modules/configs/excel2json/lua_dice_buff.lua

module("modules.configs.excel2json.lua_dice_buff", package.seeall)

local lua_dice_buff = {}
local fields = {
	triggerPoint = 8,
	effect = 7,
	name = 2,
	tag = 3,
	param = 9,
	damp = 10,
	roundLimitCount = 11,
	desc = 4,
	visible = 6,
	id = 1,
	icon = 5,
	allRoundLimitCount = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.dice_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_buff, "configList", _configList)
	rawset(lua_dice_buff, "configDict", _configDict)
end

setmetatable(lua_dice_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_buff, "configList", nil)
	rawset(lua_dice_buff, "configDict", nil)
end

return lua_dice_buff
