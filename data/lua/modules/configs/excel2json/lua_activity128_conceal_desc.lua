-- chunkname: @modules/configs/excel2json/lua_activity128_conceal_desc.lua

module("modules.configs.excel2json.lua_activity128_conceal_desc", package.seeall)

local lua_activity128_conceal_desc = {}
local fields = {
	spDesc = 2,
	maxConceal = 3,
	episodeId = 1
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	spDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity128_conceal_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_conceal_desc, "configList", _configList)
	rawset(lua_activity128_conceal_desc, "configDict", _configDict)
end

setmetatable(lua_activity128_conceal_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_conceal_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_conceal_desc, "configList", nil)
	rawset(lua_activity128_conceal_desc, "configDict", nil)
end

return lua_activity128_conceal_desc
