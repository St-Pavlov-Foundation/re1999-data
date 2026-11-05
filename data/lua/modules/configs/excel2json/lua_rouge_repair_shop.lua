-- chunkname: @modules/configs/excel2json/lua_rouge_repair_shop.lua

module("modules.configs.excel2json.lua_rouge_repair_shop", package.seeall)

local lua_rouge_repair_shop = {}
local fields = {
	id = 2,
	upConsume = 5,
	collectionId = 3,
	consume = 4,
	season = 1
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_repair_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_repair_shop, "configList", _configList)
	rawset(lua_rouge_repair_shop, "configDict", _configDict)
end

setmetatable(lua_rouge_repair_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_repair_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_repair_shop, "configList", nil)
	rawset(lua_rouge_repair_shop, "configDict", nil)
end

return lua_rouge_repair_shop
