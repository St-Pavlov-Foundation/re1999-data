-- chunkname: @framework/mvc/ConfigMgr.lua

module("framework.mvc.ConfigMgr", package.seeall)

local ConfigMgr = class("ConfigMgr")

function ConfigMgr:ctor()
	self._luaPath = "modules.configs.excel2json.lua_"
	self._requestorList = {}
	self._needLoadConfigCount = 0
	self._configNameDict = {}
	self._loadConfigCount = 0
	self._configDict = {}
	self._onLoadedCallback = nil
	self._onLoadedCallbackObj = nil
end

function ConfigMgr:init(luaPath)
	self._luaPath = luaPath
end

function ConfigMgr:addRequestor(requestor)
	table.insert(self._requestorList, requestor)

	local configNames = requestor:reqConfigNames()
	local configCount = configNames and #configNames or 0

	for i = 1, configCount do
		local configName = configNames[i]

		if not self._configNameDict[configName] then
			self._configNameDict[configName] = true
		end
	end

	self._needLoadConfigCount = tabletool.len(self._configNameDict)
end

function ConfigMgr:loadConfigs(callback, callbackObj, forceReload)
	if self._needLoadConfigCount == 0 then
		if callback then
			if callbackObj then
				callback(callbackObj)
			else
				callback()
			end
		end

		return
	end

	self._onLoadedCallback = callback
	self._onLoadedCallbackObj = callbackObj

	for configName, _ in pairs(self._configNameDict) do
		self:_onConfigLoadedV2(configName, forceReload)
	end
end

function ConfigMgr:_onConfigLoadedV2(configName, forceReload)
	local luaConfig = addGlobalModule(self._luaPath .. configName, configName)

	if not luaConfig then
		logError("config lua head not exist: <" .. configName .. ">")

		return
	end

	if not self._configDict[configName] then
		if self._configNameDict[configName] then
			self._configDict[configName] = luaConfig

			if forceReload then
				local _ = luaConfig.configList
			end

			self._loadConfigCount = self._loadConfigCount + 1
		else
			logWarn("config: <" .. configName .. "> never use, please remove it")
		end
	end

	if self._loadConfigCount == self._needLoadConfigCount and not self._requestorCbDone then
		self._requestorCbDone = true

		for _, requestor in ipairs(self._requestorList) do
			local configNames = requestor:reqConfigNames()
			local configCount = configNames and #configNames or 0

			for i = 1, configCount do
				requestor:onConfigLoaded(configNames[i], self._configDict[configNames[i]])
			end
		end

		local path = getModulePath("config_fast_load")

		if path then
			local configLoadList = addGlobalModule(path, "config_fast_load")

			if configLoadList and type(configLoadList) == "table" then
				local totalCount = tabletool.len(configLoadList)

				for i = 1, totalCount do
					local luaConfig = self._configDict[configLoadList[i]]

					if luaConfig then
						local _ = luaConfig.configList
					end
				end
			end
		end

		if self._onLoadedCallback then
			if self._onLoadedCallbackObj then
				self._onLoadedCallback(self._onLoadedCallbackObj)
			else
				self._onLoadedCallback()
			end
		end

		self._onLoadedCallback = nil
		self._onLoadedCallbackObj = nil
	end
end

function ConfigMgr:_editorCheckLuaConfig()
	local excel2jsonDir = SLFramework.FrameworkSettings.ProjLuaRootDir .. "/modules/configs/excel2json/"
	local configDir = SLFramework.FrameworkSettings.ProjLuaRootDir .. "/configs/"
	local luaFilePaths = SLFramework.FileHelper.GetDirFilePaths(excel2jsonDir)
	local configFilePaths = SLFramework.FileHelper.GetDirFilePaths(configDir)

	if not luaFilePaths or not configFilePaths then
		logError("editor check lua config fail, dir not exist: <color=red>" .. configDir .. "</color>")

		return
	end

	local configDict = {}

	for i = 0, configFilePaths.Length - 1 do
		local name = configFilePaths[i]

		if not string.find(name, ".meta") and string.find(name, "%.lua") then
			configDict[SLFramework.FileHelper.GetFileName(name, false)] = true
		end
	end

	for i = 0, luaFilePaths.Length - 1 do
		local path = luaFilePaths[i]

		if not string.find(path, ".meta") then
			local luaName = SLFramework.FileHelper.GetFileName(path, false)
			local content = SLFramework.FileHelper.ReadText(path)
			local configName = content and string.match(content, "configPath%s*=%s*\"configs%.([%w_]+)\"")

			if configName then
				if not configDict[configName] then
					logError("config lua not exist: <color=red><configs/" .. configName .. ".lua> not exist</color>, required by " .. luaName)
				end
			else
				logWarn("configPath not found in excel2json lua: " .. luaName)
			end
		end
	end
end

ConfigMgr.instance = ConfigMgr.New()

return ConfigMgr
