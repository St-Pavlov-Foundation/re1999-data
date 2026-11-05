-- chunkname: @modules/configs/excel2json/lua_survival_reward_shop.lua

module("modules.configs.excel2json.lua_survival_reward_shop", package.seeall)

local lua_survival_reward_shop = {}
local fields = {
	cost = 4,
	name = 6,
	product = 2,
	tag = 5,
	id = 1,
	maxBuyCount = 3,
	order = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_reward_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_reward_shop, "configList", _configList)
	rawset(lua_survival_reward_shop, "configDict", _configDict)
end

setmetatable(lua_survival_reward_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_reward_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_reward_shop, "configList", nil)
	rawset(lua_survival_reward_shop, "configDict", nil)
end

return lua_survival_reward_shop
