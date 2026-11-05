-- chunkname: @modules/configs/excel2json/lua_eliminate_dialog.lua

module("modules.configs.excel2json.lua_eliminate_dialog", package.seeall)

local lua_eliminate_dialog = {}
local fields = {
	auto = 5,
	dialogSeq = 2,
	id = 1,
	dialogId = 3,
	trigger = 4
}
local primaryKey = {
	"id",
	"dialogSeq"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_dialog, "configList", _configList)
	rawset(lua_eliminate_dialog, "configDict", _configDict)
end

setmetatable(lua_eliminate_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_dialog, "configList", nil)
	rawset(lua_eliminate_dialog, "configDict", nil)
end

return lua_eliminate_dialog
