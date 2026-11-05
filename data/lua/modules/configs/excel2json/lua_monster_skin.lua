-- chunkname: @modules/configs/excel2json/lua_monster_skin.lua

module("modules.configs.excel2json.lua_monster_skin", package.seeall)

local lua_monster_skin = {}
local fields = {
	retangleIcon = 12,
	weatherParam = 14,
	spine = 6,
	name = 2,
	clickBoxUnlimit = 26,
	mainBody = 22,
	nameEng = 3,
	bossSkillSpeed = 24,
	isFly = 9,
	outlineWidth = 25,
	fight_special = 7,
	skills = 10,
	effectHangPoint = 20,
	noDeadEffect = 18,
	des = 4,
	focusOffset = 16,
	effect = 19,
	matId = 13,
	topuiOffset = 15,
	headIcon = 11,
	flipX = 8,
	canHide = 21,
	colorbg = 5,
	showTemplate = 17,
	id = 1,
	floatOffset = 23
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 1
}
local _configList, _configDict
local configPath = "configs.monster_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_skin, "configList", _configList)
	rawset(lua_monster_skin, "configDict", _configDict)
end

setmetatable(lua_monster_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_skin, "configList", nil)
	rawset(lua_monster_skin, "configDict", nil)
end

return lua_monster_skin
