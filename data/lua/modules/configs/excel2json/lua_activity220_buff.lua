-- chunkname: @modules/configs/excel2json/lua_activity220_buff.lua

module("modules.configs.excel2json.lua_activity220_buff", package.seeall)

local lua_activity220_buff = {}
local fields = {
	param = 7,
	lifeRule = 3,
	buffId = 1,
	type = 6,
	attriId = 5,
	icon = 8,
	lifeParam = 4,
	isShow = 2
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_buff, "configList", _configList)
	rawset(lua_activity220_buff, "configDict", _configDict)
end

setmetatable(lua_activity220_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_buff, "configList", nil)
	rawset(lua_activity220_buff, "configDict", nil)
end

return lua_activity220_buff
