﻿-- chunkname: @projbooter/hotupdate/HotUpdateOptionPackageMgr.lua

module("projbooter.hotupdate.HotUpdateOptionPackageMgr", package.seeall)

local HotUpdateOptionPackageMgr = class("HotUpdateOptionPackageMgr")

HotUpdateOptionPackageMgr.EnableEditorDebug = false

local OptionPackageNamesKey = "HotUpdateOptionPackageMgr_OptionPackageNamesKey"

function HotUpdateOptionPackageMgr:init()
	self._optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	self._optionalUpdateInst:Init()

	self._downloader = OptionPackageDownloader.New()
	self._httpWorker = OptionPackageHttpWorker.New()
end

function HotUpdateOptionPackageMgr:getSupportVoiceLangs()
	local list = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	if not tabletool.indexOf(list, defaultLang) then
		table.insert(list, 1, defaultLang)
	end

	logNormal("\n语言：" .. defaultLang .. "\n排序：" .. table.concat(list, ","))

	return list
end

function HotUpdateOptionPackageMgr:getHotUpdateLangPacks()
	local packageList = self:getPackageNameList()

	if not packageList or #packageList < 1 then
		return nil, nil
	end

	local resLangList = {
		"res",
		"media"
	}
	local voiceLands = self:getHotUpdateVoiceLangs()

	tabletool.addValues(resLangList, voiceLands)

	local resPackList = self:formatLangPackList(resLangList, packageList)

	return resPackList
end

function HotUpdateOptionPackageMgr:getHotUpdateVoiceLangs()
	local list = self:getSupportVoiceLangs()
	local hotUpdateList = {}

	for _, lang in ipairs(list) do
		if self:isNeedDownloadVoiceLang(lang) then
			table.insert(hotUpdateList, 1, lang)
		end
	end

	return hotUpdateList
end

function HotUpdateOptionPackageMgr:isNeedDownloadVoiceLang(lang)
	if HotUpdateVoiceMgr.ForceSelect and HotUpdateVoiceMgr.ForceSelect[lang] then
		return true
	end

	local localVersion = self._optionalUpdateInst:GetLocalVersion(lang)

	if not string.nilorempty(localVersion) then
		return true
	end

	local defaultVoice = GameConfig:GetDefaultVoiceShortcut()

	if defaultVoice == lang then
		return true
	end

	return false
end

function HotUpdateOptionPackageMgr:getPackageNameList()
	local str = UnityEngine.PlayerPrefs.GetString(OptionPackageNamesKey, "")

	if not string.nilorempty(str) then
		return string.split(str, "#")
	end

	return {}
end

function HotUpdateOptionPackageMgr:savePackageNameList(packageNameList)
	local str = ""

	if packageNameList and #packageNameList > 0 then
		str = table.concat(packageNameList, "#")
	end

	UnityEngine.PlayerPrefs.SetString(OptionPackageNamesKey, str)
	UnityEngine.PlayerPrefs.Save()
end

function HotUpdateOptionPackageMgr:showDownload(onFinish, finishObj, adppter)
	local httpGetList = adppter and adppter:getHttpGetterList()

	if not httpGetList or #httpGetList < 1 then
		onFinish(finishObj)

		return
	end

	self._adppter = adppter

	self._adppter:setDownloder(self._downloader, self)

	if VersionValidator.instance:isInReviewing() then
		onFinish(finishObj)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateOptionPackageMgr.EnableEditorDebug then
		onFinish(finishObj)
	else
		self._httpWorker:start(httpGetList, onFinish, finishObj)
	end
end

function HotUpdateOptionPackageMgr:startDownload(onFinish, finishObj)
	if VersionValidator.instance:isInReviewing() and not HotUpdateOptionPackageMgr.EnableEditorDebug then
		onFinish(finishObj)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateOptionPackageMgr.EnableEditorDebug then
		onFinish(finishObj)
	elseif BootNativeUtil.isIOS() and HotUpdateMgr.instance:hasHotUpdate() then
		logNormal("热更新紧接着语音更新，延迟开始")

		local timer = Timer.New(function()
			logNormal("独立资源包更新开始")
			self._downloader:start(self:getHttpResult(), onFinish, finishObj, self._adppter)
		end, 1.5)

		timer:Start()
	else
		self._downloader:start(self:getHttpResult(), onFinish, finishObj, self._adppter)
	end
end

function HotUpdateOptionPackageMgr:getHttpResult()
	return self._httpWorker:getHttpResult()
end

function HotUpdateOptionPackageMgr:getNeedDownloadSize()
	local result = self:getHttpResult()

	if not result then
		return 0
	end

	local size = 0

	for packName, packInfoTb in pairs(result) do
		local downloadList = packInfoTb.res

		if downloadList then
			local names = {}
			local hashs = {}
			local orders = {}
			local lengths = {}

			for _, one in ipairs(downloadList) do
				table.insert(names, one.name)
				table.insert(hashs, one.hash)
				table.insert(orders, one.order)
				table.insert(lengths, one.length)

				size = size + one.length
			end

			self._optionalUpdateInst:InitBreakPointInfo(names, hashs, orders, lengths)

			local recvSize = self._optionalUpdateInst:GetRecvSize()

			recvSize = tonumber(recvSize)
			size = size - recvSize
		end
	end

	return size
end

function HotUpdateOptionPackageMgr:getTotalSize()
	local result = self:getHttpResult()

	if not result then
		return 0
	end

	local size = 0

	for packName, packInfoTb in pairs(result) do
		local downloadList = packInfoTb.res

		if downloadList then
			local names = {}
			local hashs = {}
			local orders = {}
			local lengths = {}

			for _, one in ipairs(downloadList) do
				table.insert(names, one.name)
				table.insert(hashs, one.hash)
				table.insert(orders, one.order)
				table.insert(lengths, one.length)

				size = size + one.length
			end
		end
	end

	return size
end

function HotUpdateOptionPackageMgr:formatLangPackList(langList, packageList)
	local langPackList = {}

	if not packageList or #packageList < 1 then
		tabletool.addValues(langPackList, langList)

		return langPackList
	end

	for _, packageName in ipairs(packageList) do
		for _i, lang in ipairs(langList) do
			table.insert(langPackList, self:formatLangPackName(lang, packageName))
		end
	end

	return langPackList
end

function HotUpdateOptionPackageMgr:formatLangPackName(lang, packageName)
	if string.nilorempty(packageName) then
		return lang
	end

	return string.format("%s-%s", lang, packageName)
end

function HotUpdateOptionPackageMgr:stop()
	self._downloader:cancelDownload()
end

HotUpdateOptionPackageMgr.instance = HotUpdateOptionPackageMgr.New()

return HotUpdateOptionPackageMgr
