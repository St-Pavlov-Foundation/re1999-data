-- chunkname: @modules/configs/excel2json/lua_partygame_findheart.lua

module("modules.configs.excel2json.lua_partygame_findheart", package.seeall)

local lua_partygame_findheart = {}
local fields = {
	id = 1,
	answergroup = 3,
	difficulty = 2
}
local primaryKey = {
	"id",
	"difficulty"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_findheart_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_findheart, "configList", _configList)
	rawset(lua_partygame_findheart, "configDict", _configDict)
end

setmetatable(lua_partygame_findheart, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_findheart.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_findheart, "configList", nil)
	rawset(lua_partygame_findheart, "configDict", nil)
end

return lua_partygame_findheart
