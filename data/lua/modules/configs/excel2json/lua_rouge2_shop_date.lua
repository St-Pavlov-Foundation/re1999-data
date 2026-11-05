-- chunkname: @modules/configs/excel2json/lua_rouge2_shop_date.lua

module("modules.configs.excel2json.lua_rouge2_shop_date", package.seeall)

local lua_rouge2_shop_date = {}
local fields = {
	currencyMax = 5,
	shopTitle = 4,
	endTime = 3,
	id = 1,
	startTime = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	shopTitle = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_shop_date_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_shop_date, "configList", _configList)
	rawset(lua_rouge2_shop_date, "configDict", _configDict)
end

setmetatable(lua_rouge2_shop_date, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_shop_date.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_shop_date, "configList", nil)
	rawset(lua_rouge2_shop_date, "configDict", nil)
end

return lua_rouge2_shop_date
