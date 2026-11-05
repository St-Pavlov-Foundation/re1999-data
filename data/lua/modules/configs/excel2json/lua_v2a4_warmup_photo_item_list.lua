-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_photo_item_list.lua

module("modules.configs.excel2json.lua_v2a4_warmup_photo_item_list", package.seeall)

local lua_v2a4_warmup_photo_item_list = {}
local fields = {
	imgName = 3,
	yes3 = 12,
	yes1 = 8,
	passTalkAllYes = 5,
	yes2 = 10,
	no2 = 11,
	preTalk = 4,
	passTalk = 6,
	failTalk = 7,
	no3 = 13,
	id = 1,
	no1 = 9,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_photo_item_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_photo_item_list, "configList", _configList)
	rawset(lua_v2a4_warmup_photo_item_list, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_photo_item_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_photo_item_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_photo_item_list, "configList", nil)
	rawset(lua_v2a4_warmup_photo_item_list, "configDict", nil)
end

return lua_v2a4_warmup_photo_item_list
