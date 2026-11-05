-- chunkname: @modules/configs/excel2json/lua_rouge_repair_shop_price.lua

module("modules.configs.excel2json.lua_rouge_repair_shop_price", package.seeall)

local lua_rouge_repair_shop_price = {}
local fields = {
	id = 1,
	unlockType = 2,
	desc = 4,
	unlockParam = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_repair_shop_price_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_repair_shop_price, "configList", _configList)
	rawset(lua_rouge_repair_shop_price, "configDict", _configDict)
end

setmetatable(lua_rouge_repair_shop_price, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_repair_shop_price.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_repair_shop_price, "configList", nil)
	rawset(lua_rouge_repair_shop_price, "configDict", nil)
end

return lua_rouge_repair_shop_price
