-- chunkname: @modules/configs/excel2json/lua_cloth.lua

module("modules.configs.excel2json.lua_cloth", package.seeall)

local lua_cloth = {}
local fields = {
	name = 2,
	skinId = 5,
	id = 1,
	icon = 4,
	enname = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.cloth_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_cloth, "configList", _configList)
	rawset(lua_cloth, "configDict", _configDict)
end

setmetatable(lua_cloth, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_cloth.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_cloth, "configList", nil)
	rawset(lua_cloth, "configDict", nil)
end

return lua_cloth
