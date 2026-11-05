-- chunkname: @modules/configs/excel2json/lua_fight_qte_skillgroup.lua

module("modules.configs.excel2json.lua_fight_qte_skillgroup", package.seeall)

local lua_fight_qte_skillgroup = {}
local fields = {
	qteGoupId = 1,
	passiveId2 = 4,
	passiveId1 = 3,
	endId = 5,
	activeId = 2
}
local primaryKey = {
	"qteGoupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_qte_skillgroup_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_qte_skillgroup, "configList", _configList)
	rawset(lua_fight_qte_skillgroup, "configDict", _configDict)
end

setmetatable(lua_fight_qte_skillgroup, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_qte_skillgroup.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_qte_skillgroup, "configList", nil)
	rawset(lua_fight_qte_skillgroup, "configDict", nil)
end

return lua_fight_qte_skillgroup
