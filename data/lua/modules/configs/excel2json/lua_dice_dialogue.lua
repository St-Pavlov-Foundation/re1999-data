-- chunkname: @modules/configs/excel2json/lua_dice_dialogue.lua

module("modules.configs.excel2json.lua_dice_dialogue", package.seeall)

local lua_dice_dialogue = {}
local fields = {
	speaker = 3,
	desc = 4,
	line = 5,
	type = 6,
	id = 1,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	speaker = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.dice_dialogue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_dialogue, "configList", _configList)
	rawset(lua_dice_dialogue, "configDict", _configDict)
end

setmetatable(lua_dice_dialogue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_dialogue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_dialogue, "configList", nil)
	rawset(lua_dice_dialogue, "configDict", nil)
end

return lua_dice_dialogue
