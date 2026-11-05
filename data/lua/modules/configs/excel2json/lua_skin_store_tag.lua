-- chunkname: @modules/configs/excel2json/lua_skin_store_tag.lua

module("modules.configs.excel2json.lua_skin_store_tag", package.seeall)

local lua_skin_store_tag = {}
local fields = {
	id = 1,
	color = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.skin_store_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_store_tag, "configList", _configList)
	rawset(lua_skin_store_tag, "configDict", _configDict)
end

setmetatable(lua_skin_store_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_store_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_store_tag, "configList", nil)
	rawset(lua_skin_store_tag, "configDict", nil)
end

return lua_skin_store_tag
