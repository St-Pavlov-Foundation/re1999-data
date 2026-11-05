-- chunkname: @modules/configs/excel2json/lua_block_package_data.lua

module("modules.configs.excel2json.lua_block_package_data", package.seeall)

local lua_block_package_data = {}
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
local _configList, _configDict, _packageDict
local configPath = "configs.block_package_data_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict, _packageDict = lua_block_package_data.json_parse(config)

	rawset(lua_block_package_data, "configList", _configList)
	rawset(lua_block_package_data, "configDict", _configDict)
	rawset(lua_block_package_data, "packageDict", _packageDict)
end

setmetatable(lua_block_package_data, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_package_data.clearConfig()
	_configList, _configDict, _packageDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_package_data, "configList", nil)
	rawset(lua_block_package_data, "configDict", nil)
	rawset(lua_block_package_data, "packageDict", nil)
end

function lua_block_package_data.json_parse(json)
	local configList = {}
	local configDict = {}
	local packageDict = {}

	for _, packageCfg in ipairs(json) do
		if not packageDict[packageCfg.id] then
			packageDict[packageCfg.id] = {}
		end

		local packageList = packageDict[packageCfg.id]

		for i, cfg in ipairs(packageCfg.infos) do
			cfg.packageId = packageCfg.id
			cfg.packageOrder = i

			table.insert(configList, cfg)

			configDict[cfg.blockId] = cfg

			table.insert(packageList, cfg)
		end
	end

	return configList, configDict, packageDict
end

return lua_block_package_data
