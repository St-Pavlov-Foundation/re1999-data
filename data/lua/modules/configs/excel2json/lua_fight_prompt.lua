-- chunkname: @modules/configs/excel2json/lua_fight_prompt.lua

module("modules.configs.excel2json.lua_fight_prompt", package.seeall)

local lua_fight_prompt = {}
local fields = {
	id = 1,
	color = 3,
	content = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.fight_prompt_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_prompt, "configList", _configList)
	rawset(lua_fight_prompt, "configDict", _configDict)
end

setmetatable(lua_fight_prompt, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_prompt.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_prompt, "configList", nil)
	rawset(lua_fight_prompt, "configDict", nil)
end

return lua_fight_prompt
