-- chunkname: @modules/configs/excel2json/lua_block_init.lua

module("modules.configs.excel2json.lua_block_init", package.seeall)

local lua_block_init = {}
local fields = {
	packageId = 3,
	blockId = 2,
	mainRes = 5,
	defineId = 1,
	order = 4
}
local primaryKey = {
	"blockId"
}
local mlStringKey = {}
local _configList, _configDict, _poscfgDict
local configPath = "configs.block_init_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict, _poscfgDict = lua_block_init.json_parse(config)

	rawset(lua_block_init, "configList", _configList)
	rawset(lua_block_init, "configDict", _configDict)
	rawset(lua_block_init, "poscfgDict", _poscfgDict)
end

setmetatable(lua_block_init, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_init.clearConfig()
	_configList, _configDict, _poscfgDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_init, "configList", nil)
	rawset(lua_block_init, "configDict", nil)
	rawset(lua_block_init, "poscfgDict", nil)
end

function lua_block_init.json_parse(json)
	local configList = {}
	local configDict = {}
	local poscfgDict = {}

	if json.infos then
		for i, info in ipairs(json.infos) do
			local config = {}

			config.blockId = info.blockId
			config.defineId = info.defineId
			config.mainRes = info.mainRes
			config.packageId = -1
			config.order = -1

			table.insert(configList, config)

			configDict[config.blockId] = config

			if not poscfgDict[info.x] then
				poscfgDict[info.x] = {}
			end

			poscfgDict[info.x][info.y] = info
		end
	end

	return configList, configDict, poscfgDict
end

return lua_block_init
