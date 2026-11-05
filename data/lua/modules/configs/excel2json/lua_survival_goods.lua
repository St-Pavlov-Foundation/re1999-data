-- chunkname: @modules/configs/excel2json/lua_survival_goods.lua

module("modules.configs.excel2json.lua_survival_goods", package.seeall)

local lua_survival_goods = {}
local fields = {
	id = 1,
	shopGroup = 2,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_goods_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_goods, "configList", _configList)
	rawset(lua_survival_goods, "configDict", _configDict)
end

setmetatable(lua_survival_goods, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_goods.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_goods, "configList", nil)
	rawset(lua_survival_goods, "configDict", nil)
end

return lua_survival_goods
