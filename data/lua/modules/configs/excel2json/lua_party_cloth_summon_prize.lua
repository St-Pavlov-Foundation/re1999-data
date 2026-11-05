-- chunkname: @modules/configs/excel2json/lua_party_cloth_summon_prize.lua

module("modules.configs.excel2json.lua_party_cloth_summon_prize", package.seeall)

local lua_party_cloth_summon_prize = {}
local fields = {
	groupId = 1,
	prizeParams = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.party_cloth_summon_prize_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_cloth_summon_prize, "configList", _configList)
	rawset(lua_party_cloth_summon_prize, "configDict", _configDict)
end

setmetatable(lua_party_cloth_summon_prize, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_cloth_summon_prize.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_cloth_summon_prize, "configList", nil)
	rawset(lua_party_cloth_summon_prize, "configDict", nil)
end

return lua_party_cloth_summon_prize
