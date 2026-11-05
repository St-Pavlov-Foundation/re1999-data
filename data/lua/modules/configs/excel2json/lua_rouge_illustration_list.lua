-- chunkname: @modules/configs/excel2json/lua_rouge_illustration_list.lua

module("modules.configs.excel2json.lua_rouge_illustration_list", package.seeall)

local lua_rouge_illustration_list = {}
local fields = {
	nameEn = 5,
	name = 4,
	eventId = 9,
	fullImage = 8,
	season = 1,
	image = 7,
	desc = 6,
	dlc = 10,
	id = 2,
	order = 3
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_illustration_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_illustration_list, "configList", _configList)
	rawset(lua_rouge_illustration_list, "configDict", _configDict)
end

setmetatable(lua_rouge_illustration_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_illustration_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_illustration_list, "configList", nil)
	rawset(lua_rouge_illustration_list, "configDict", nil)
end

return lua_rouge_illustration_list
