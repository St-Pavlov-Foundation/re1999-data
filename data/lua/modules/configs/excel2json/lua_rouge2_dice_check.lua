-- chunkname: @modules/configs/excel2json/lua_rouge2_dice_check.lua

module("modules.configs.excel2json.lua_rouge2_dice_check", package.seeall)

local lua_rouge2_dice_check = {}
local fields = {
	dice = 6,
	attrType = 4,
	desc = 5,
	retryCost = 7,
	id = 1,
	checkPoint = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_dice_check_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_dice_check, "configList", _configList)
	rawset(lua_rouge2_dice_check, "configDict", _configDict)
end

setmetatable(lua_rouge2_dice_check, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_dice_check.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_dice_check, "configList", nil)
	rawset(lua_rouge2_dice_check, "configDict", nil)
end

return lua_rouge2_dice_check
