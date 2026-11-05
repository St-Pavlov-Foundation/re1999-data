-- chunkname: @modules/configs/excel2json/lua_equip_tag.lua

module("modules.configs.excel2json.lua_equip_tag", package.seeall)

local lua_equip_tag = {}
local fields = {
	id = 1,
	name = 2,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.equip_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_tag, "configList", _configList)
	rawset(lua_equip_tag, "configDict", _configDict)
end

setmetatable(lua_equip_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_tag, "configList", nil)
	rawset(lua_equip_tag, "configDict", nil)
end

return lua_equip_tag
