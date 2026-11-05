-- chunkname: @modules/configs/excel2json/lua_fight_technique.lua

module("modules.configs.excel2json.lua_fight_technique", package.seeall)

local lua_fight_technique = {}
local fields = {
	title_cn = 7,
	iconShow = 9,
	picture1 = 10,
	picture2 = 11,
	mainTitleId = 2,
	noDisplayType = 15,
	condition = 4,
	displayType = 14,
	isCn = 13,
	title_en = 8,
	mainTitle_en = 6,
	mainTitle_cn = 5,
	id = 1,
	content1 = 12,
	group = 16,
	subTitleId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title_cn = 3,
	content1 = 4,
	mainTitle_en = 2,
	mainTitle_cn = 1
}
local _configList, _configDict
local configPath = "configs.fight_technique_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_technique, "configList", _configList)
	rawset(lua_fight_technique, "configDict", _configDict)
end

setmetatable(lua_fight_technique, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_technique.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_technique, "configList", nil)
	rawset(lua_fight_technique, "configDict", nil)
end

return lua_fight_technique
