-- chunkname: @modules/configs/excel2json/lua_slow_release_gift.lua

module("modules.configs.excel2json.lua_slow_release_gift", package.seeall)

local lua_slow_release_gift = {}
local fields = {
	onceBonus = 3,
	desc2 = 6,
	dailyBonus = 4,
	days = 2,
	id = 1,
	desc1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 2,
	desc1 = 1
}
local _configList, _configDict
local configPath = "configs.slow_release_gift_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_slow_release_gift, "configList", _configList)
	rawset(lua_slow_release_gift, "configDict", _configDict)
end

setmetatable(lua_slow_release_gift, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_slow_release_gift.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_slow_release_gift, "configList", nil)
	rawset(lua_slow_release_gift, "configDict", nil)
end

return lua_slow_release_gift
