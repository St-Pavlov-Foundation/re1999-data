-- chunkname: @modules/configs/excel2json/lua_rouge_item_static_desc.lua

module("modules.configs.excel2json.lua_rouge_item_static_desc", package.seeall)

local lua_rouge_item_static_desc = {}
local fields = {
	item1_attr = 3,
	id = 1,
	item3 = 6,
	item2_attr = 5,
	item2 = 4,
	item3_attr = 7,
	item1 = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_item_static_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_item_static_desc, "configList", _configList)
	rawset(lua_rouge_item_static_desc, "configDict", _configDict)
end

setmetatable(lua_rouge_item_static_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_item_static_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_item_static_desc, "configList", nil)
	rawset(lua_rouge_item_static_desc, "configDict", nil)
end

return lua_rouge_item_static_desc
