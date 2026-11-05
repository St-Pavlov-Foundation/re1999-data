-- chunkname: @modules/configs/excel2json/lua_odyssey_religion_clue.lua

module("modules.configs.excel2json.lua_odyssey_religion_clue", package.seeall)

local lua_odyssey_religion_clue = {}
local fields = {
	id = 1,
	unlockCondition = 3,
	clue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	clue = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_religion_clue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_religion_clue, "configList", _configList)
	rawset(lua_odyssey_religion_clue, "configDict", _configDict)
end

setmetatable(lua_odyssey_religion_clue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_religion_clue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_religion_clue, "configList", nil)
	rawset(lua_odyssey_religion_clue, "configDict", nil)
end

return lua_odyssey_religion_clue
