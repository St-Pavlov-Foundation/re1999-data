-- chunkname: @modules/configs/excel2json/lua_fight_hnj_helmet_spine.lua

module("modules.configs.excel2json.lua_fight_hnj_helmet_spine", package.seeall)

local lua_fight_hnj_helmet_spine = {}
local fields = {
	pos = 3,
	effect = 4,
	hangPoint = 5,
	skinId = 1,
	resPath = 2
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_hnj_helmet_spine_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_hnj_helmet_spine, "configList", _configList)
	rawset(lua_fight_hnj_helmet_spine, "configDict", _configDict)
end

setmetatable(lua_fight_hnj_helmet_spine, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_hnj_helmet_spine.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_hnj_helmet_spine, "configList", nil)
	rawset(lua_fight_hnj_helmet_spine, "configDict", nil)
end

return lua_fight_hnj_helmet_spine
