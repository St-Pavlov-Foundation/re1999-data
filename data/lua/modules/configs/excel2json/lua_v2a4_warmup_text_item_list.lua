-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_text_item_list.lua

module("modules.configs.excel2json.lua_v2a4_warmup_text_item_list", package.seeall)

local lua_v2a4_warmup_text_item_list = {}
local fields = {
	yes2 = 12,
	yes3 = 15,
	no3 = 16,
	info2 = 11,
	yes5 = 21,
	info4 = 17,
	yes6 = 24,
	yes4 = 18,
	passTalkAllYes = 5,
	info3 = 14,
	imgName = 3,
	no5 = 22,
	passTalk = 6,
	no4 = 19,
	no6 = 25,
	level = 2,
	yes1 = 9,
	no2 = 13,
	info5 = 20,
	preTalk = 4,
	failTalk = 7,
	info6 = 23,
	id = 1,
	info1 = 8,
	no1 = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_text_item_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_text_item_list, "configList", _configList)
	rawset(lua_v2a4_warmup_text_item_list, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_text_item_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_text_item_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_text_item_list, "configList", nil)
	rawset(lua_v2a4_warmup_text_item_list, "configDict", nil)
end

return lua_v2a4_warmup_text_item_list
