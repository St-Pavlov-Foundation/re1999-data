-- chunkname: @modules/configs/excel2json/lua_summon_equip_detail.lua

module("modules.configs.excel2json.lua_summon_equip_detail", package.seeall)

local lua_summon_equip_detail = {}
local fields = {
	texture = 4,
	texturePoster = 5,
	equipId = 3,
	location = 6,
	id = 1,
	poolId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_equip_detail_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_equip_detail, "configList", _configList)
	rawset(lua_summon_equip_detail, "configDict", _configDict)
end

setmetatable(lua_summon_equip_detail, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_equip_detail.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_equip_detail, "configList", nil)
	rawset(lua_summon_equip_detail, "configDict", nil)
end

return lua_summon_equip_detail
