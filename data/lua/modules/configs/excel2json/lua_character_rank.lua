-- chunkname: @modules/configs/excel2json/lua_character_rank.lua

module("modules.configs.excel2json.lua_character_rank", package.seeall)

local lua_character_rank = {}
local fields = {
	requirement = 4,
	heroId = 1,
	rank = 2,
	consume = 3,
	effect = 5
}
local primaryKey = {
	"heroId",
	"rank"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_rank_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_rank, "configList", _configList)
	rawset(lua_character_rank, "configDict", _configDict)
end

setmetatable(lua_character_rank, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_rank.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_rank, "configList", nil)
	rawset(lua_character_rank, "configDict", nil)
end

return lua_character_rank
