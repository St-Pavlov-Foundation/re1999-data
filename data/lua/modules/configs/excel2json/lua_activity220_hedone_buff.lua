-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_buff.lua

module("modules.configs.excel2json.lua_activity220_hedone_buff", package.seeall)

local lua_activity220_hedone_buff = {}
local fields = {
	lifeRule = 2,
	lifeParam = 4,
	buffId = 1,
	subLifeRule = 3,
	affectParam = 6,
	affectType = 5
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_hedone_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_hedone_buff, "configList", _configList)
	rawset(lua_activity220_hedone_buff, "configDict", _configDict)
end

setmetatable(lua_activity220_hedone_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_hedone_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_hedone_buff, "configList", nil)
	rawset(lua_activity220_hedone_buff, "configDict", nil)
end

return lua_activity220_hedone_buff
