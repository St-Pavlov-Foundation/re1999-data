-- chunkname: @modules/configs/excel2json/lua_character_shop_voice.lua

module("modules.configs.excel2json.lua_character_shop_voice", package.seeall)

local lua_character_shop_voice = {}
local fields = {
	jpmouth = 37,
	name = 4,
	heroId = 1,
	type = 9,
	frcontent = 17,
	unlockCondition = 6,
	thaiface = 34,
	jpcontent = 14,
	thaicontent = 18,
	content = 11,
	motion = 19,
	displayTime = 43,
	twface = 28,
	skins = 5,
	decontent = 16,
	show = 8,
	twcontent = 13,
	face = 27,
	frmotion = 25,
	twmouth = 36,
	enface = 30,
	enmouth = 38,
	encontent = 12,
	demouth = 40,
	thaimouth = 42,
	kocontent = 15,
	twmotion = 20,
	param = 10,
	komotion = 23,
	jpface = 29,
	komouth = 39,
	frmouth = 41,
	frface = 33,
	demotion = 24,
	koface = 31,
	thaimotion = 26,
	mouth = 35,
	jpmotion = 21,
	sortId = 3,
	deface = 32,
	time = 7,
	audio = 2,
	enmotion = 22
}
local primaryKey = {
	"heroId",
	"audio"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_shop_voice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_shop_voice, "configList", _configList)
	rawset(lua_character_shop_voice, "configDict", _configDict)
end

setmetatable(lua_character_shop_voice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_shop_voice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_shop_voice, "configList", nil)
	rawset(lua_character_shop_voice, "configDict", nil)
end

return lua_character_shop_voice
