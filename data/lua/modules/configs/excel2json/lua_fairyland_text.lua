-- chunkname: @modules/configs/excel2json/lua_fairyland_text.lua

module("modules.configs.excel2json.lua_fairyland_text", package.seeall)

local lua_fairyland_text = {}
local fields = {
	id = 1,
	node = 4,
	question = 2,
	answer = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	question = 1,
	answer = 2
}
local _configList, _configDict
local configPath = "configs.fairyland_text_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fairyland_text, "configList", _configList)
	rawset(lua_fairyland_text, "configDict", _configDict)
end

setmetatable(lua_fairyland_text, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fairyland_text.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fairyland_text, "configList", nil)
	rawset(lua_fairyland_text, "configDict", nil)
end

return lua_fairyland_text
