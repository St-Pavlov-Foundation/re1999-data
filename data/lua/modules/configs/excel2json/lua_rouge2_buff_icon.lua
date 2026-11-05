-- chunkname: @modules/configs/excel2json/lua_rouge2_buff_icon.lua

module("modules.configs.excel2json.lua_rouge2_buff_icon", package.seeall)

local lua_rouge2_buff_icon = {}
local fields = {
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_buff_icon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_buff_icon, "configList", _configList)
	rawset(lua_rouge2_buff_icon, "configDict", _configDict)
end

setmetatable(lua_rouge2_buff_icon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_buff_icon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_buff_icon, "configList", nil)
	rawset(lua_rouge2_buff_icon, "configDict", nil)
end

return lua_rouge2_buff_icon
