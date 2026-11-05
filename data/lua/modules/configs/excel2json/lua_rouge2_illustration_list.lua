-- chunkname: @modules/configs/excel2json/lua_rouge2_illustration_list.lua

module("modules.configs.excel2json.lua_rouge2_illustration_list", package.seeall)

local lua_rouge2_illustration_list = {}
local fields = {
	nameEn = 6,
	name = 3,
	fullImage = 9,
	type = 5,
	eventId = 10,
	image = 8,
	desc = 7,
	nameOther = 4,
	id = 1,
	eventAttribute = 11,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameOther = 2,
	name = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.rouge2_illustration_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_illustration_list, "configList", _configList)
	rawset(lua_rouge2_illustration_list, "configDict", _configDict)
end

setmetatable(lua_rouge2_illustration_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_illustration_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_illustration_list, "configList", nil)
	rawset(lua_rouge2_illustration_list, "configDict", nil)
end

return lua_rouge2_illustration_list
