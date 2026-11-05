-- chunkname: @modules/configs/excel2json/lua_heduonie_specialcard_client.lua

module("modules.configs.excel2json.lua_heduonie_specialcard_client", package.seeall)

local lua_heduonie_specialcard_client = {}
local fields = {
	roleid = 1,
	skillcard = 3,
	skillLevel = 2
}
local primaryKey = {
	"roleid",
	"skillLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.heduonie_specialcard_client_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_heduonie_specialcard_client, "configList", _configList)
	rawset(lua_heduonie_specialcard_client, "configDict", _configDict)
end

setmetatable(lua_heduonie_specialcard_client, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_heduonie_specialcard_client.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_heduonie_specialcard_client, "configList", nil)
	rawset(lua_heduonie_specialcard_client, "configDict", nil)
end

return lua_heduonie_specialcard_client
