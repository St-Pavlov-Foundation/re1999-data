-- chunkname: @modules/configs/excel2json/lua_survival_block.lua

module("modules.configs.excel2json.lua_survival_block", package.seeall)

local lua_survival_block = {}
local fields = {
	preAttrDesc = 10,
	name = 2,
	rotate = 7,
	grid = 6,
	resource = 5,
	preAttr = 9,
	subType = 4,
	copyIds = 3,
	id = 1,
	weight = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	preAttrDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_block_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_block, "configList", _configList)
	rawset(lua_survival_block, "configDict", _configDict)
end

setmetatable(lua_survival_block, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_block.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_block, "configList", nil)
	rawset(lua_survival_block, "configDict", nil)
end

return lua_survival_block
