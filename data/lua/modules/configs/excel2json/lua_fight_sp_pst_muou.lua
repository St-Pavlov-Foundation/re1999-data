-- chunkname: @modules/configs/excel2json/lua_fight_sp_pst_muou.lua

module("modules.configs.excel2json.lua_fight_sp_pst_muou", package.seeall)

local lua_fight_sp_pst_muou = {}
local fields = {
	bornAudio = 8,
	bornDuration = 9,
	spineRes = 2,
	dieDuration = 13,
	dieAudio = 12,
	dieHangPoint = 11,
	offset = 3,
	dieEffect = 10,
	bornHangPoint = 7,
	id = 1,
	bornEffect = 6,
	scale = 4,
	actionName = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_pst_muou_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_pst_muou, "configList", _configList)
	rawset(lua_fight_sp_pst_muou, "configDict", _configDict)
end

setmetatable(lua_fight_sp_pst_muou, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_pst_muou.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_pst_muou, "configList", nil)
	rawset(lua_fight_sp_pst_muou, "configDict", nil)
end

return lua_fight_sp_pst_muou
