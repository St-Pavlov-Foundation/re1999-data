﻿-- chunkname: @modules/logic/optionpackage/controller/OptionPackageController.lua

module("modules.logic.optionpackage.controller.OptionPackageController", package.seeall)

local OptionPackageController = class("OptionPackageController", BaseController)

function OptionPackageController:onInit()
	self._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	self._optionalUpdateInst = self._optionalUpdate.Instance
	self._initialized = false

	if not HotUpdateVoiceMgr then
		return
	end

	self._initialized = true
	self._downloader = OptionPackageDownloader.New()
	self._httpWorker = OptionPackageHttpWorker.New()
	self._adapter = DownloadOptPackAdapter.New()
end

function OptionPackageController:onInitFinish()
	if not self._initialized then
		return
	end

	TaskDispatcher.runDelay(self._startHttpWorker, self, 10)

	self._localPackageNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	self:_updateLocalVersion()
end

function OptionPackageController:addConstEvents()
	return
end

function OptionPackageController:reInit()
	return
end

function OptionPackageController:_startHttpWorker()
	logNormal("OptionPackageController:_startHttpWorker()")

	local packageNameList = OptionPackageEnum.PackageNameList

	if #packageNameList < 1 then
		return
	end

	local httpGeterList = {}
	local voiceLangs = OptionPackageModel.instance:getSupportVoiceLangs()
	local langStrList = {}

	tabletool.addValues(langStrList, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(langStrList, voiceLangs)

	if langStrList and #langStrList > 0 then
		local langPackList = HotUpdateOptionPackageMgr.instance:formatLangPackList(langStrList, packageNameList)

		table.insert(httpGeterList, OptionPackageHttpGetter.New(OptionPackageEnum.SourceType.OptResVoice, langPackList))
	end

	self._httpWorkerRequestCount = 0

	self._httpWorker:start(httpGeterList, self._onHttpWorkerDone, self)
end

function OptionPackageController:_onHttpWorkerDone(isAllSuccess)
	if not isAllSuccess and self._httpWorkerRequestCount < 3 then
		self._httpWorkerRequestCount = self._httpWorkerRequestCount + 1

		self._httpWorker:againGetHttp(self._onHttpWorkerDone, self)

		return
	end

	if not isAllSuccess then
		self:_endHttpBlock()

		return
	end

	local httpResult = self._httpWorker:getHttpResult()

	for langPackName, packInfoTb in pairs(httpResult) do
		local packMO = OptionPackageModel.instance:getPackageMO(langPackName)

		if not packMO then
			local arrs = string.split(langPackName, "-")

			if arrs and #arrs > 1 then
				packMO = OptionPackageMO.New()

				local lang = arrs[1]
				local packageName = arrs[2]

				packMO:init(packageName, lang)
				OptionPackageModel.instance:addPackageMO(packMO)
			end
		end

		if packMO then
			logNormal(string.format("packMO:setPackInfo() langPackName :%s localVersion:%s", langPackName, packMO.localVersion))
			packMO:setPackInfo(packInfoTb)

			if #packMO.downloadResList.names > 0 then
				local res = packMO.downloadResList

				self._optionalUpdateInst:InitBreakPointInfo(res.names, res.hashs, res.orders, res.lengths)

				local recvSize = self._optionalUpdateInst:GetRecvSize()

				recvSize = tonumber(recvSize)

				packMO:setLocalSize(recvSize)
			end
		end
	end

	self:_endHttpBlock()
end

function OptionPackageController:_updateLocalVersion()
	local packMOList = OptionPackageModel.instance:getPackageMOList()

	for _, packMO in ipairs(packMOList) do
		if packMO then
			local localVersion = self:getLocalVersionInt(packMO.langPack)

			packMO:setLocalVersion(localVersion)
		end
	end
end

OptionPackageController.OPTION_PACKAGE_HTTP_REQUEST = "OptionPackageController.OPTION_PACKAGE_HTTP_REQUEST"

function OptionPackageController:_startHttpBlock()
	UIBlockMgr.instance:startBlock(OptionPackageController.OPTION_PACKAGE_HTTP_REQUEST)
	TaskDispatcher.cancelTask(self._endHttpBlock, self)
	TaskDispatcher.runDelay(self._endHttpBlock, self, 10)
end

function OptionPackageController:_endHttpBlock()
	TaskDispatcher.cancelTask(self._endHttpBlock, self)
	UIBlockMgr.instance:endBlock(OptionPackageController.OPTION_PACKAGE_HTTP_REQUEST)
end

function OptionPackageController:checkNeedDownload(packName)
	if not self._initialized or not OptionPackageEnum.HasPackageNameDict[packName] then
		return false
	end

	if GameResMgr.IsFromEditorDir and not HotUpdateOptionPackageMgr.EnableEditorDebug then
		return false
	end

	local isDone, isAllSuccess = self._httpWorker:checkWorkDone()

	if not isDone then
		self:_startHttpBlock()

		return true
	end

	if isDone and not isAllSuccess then
		self._httpWorker:againGetHttp(self._onHttpWorkerDone, self)
		self:_startHttpBlock()

		return true
	end

	local packageSetMO = OptionPackageModel.instance:getPackageSetMO(packName)
	local curVoiceLangs = OptionPackageModel.instance:getNeedVoiceLangList()

	if packageSetMO:isNeedDownload(curVoiceLangs) then
		local allSize, localSize = packageSetMO:getDownloadSize(curVoiceLangs)
		local needDownloadSize, size, units = OptionPackageHelper.getLeftSizeMBorGB(allSize, localSize)
		local tipsStr = string.format("是否下载常驻活动资源？\n资源大小:%.2f%s", needDownloadSize, units)

		self:_showDownloadMsgBox(packName, tipsStr)

		return true
	end

	return false
end

function OptionPackageController:_showDownloadMsgBox(packName, tipsStr)
	self._downloadPackName = packName

	local messageBoxId = MessageBoxIdDefine.ForbidLogin
	local msgBoxType = MsgBoxEnum.BoxType.Yes_No
	local yesStr = "确定下载"
	local yesStrEn = "YES DOWNLOAD"
	local noStr = "取消下载"
	local noStrEn = "CANCEL DOWNLOAD"
	local yesCallback = OptionPackageController._downloaderYes
	local noCallback = OptionPackageController._downloaderNo

	MessageBoxController.instance:showSystemMsgBox(messageBoxId, msgBoxType, yesCallback, noCallback, nil, nil, nil, nil, tipsStr)
end

function OptionPackageController:stopDownload()
	if self._downloader then
		self._downloader:cancelDownload()
	end

	OptionPackageController.instance._downloadPackName = nil

	self:_updateLocalVersion()
	ViewMgr.instance:closeView(ViewName.OptionPackageDownloadView)
end

function OptionPackageController._downloaderNo()
	OptionPackageController.instance._downloadPackName = nil
end

function OptionPackageController._downloaderYes()
	OptionPackageController.instance:_onStartDownload()
end

function OptionPackageController:_onStartDownload()
	local packSetName = self._downloadPackName

	self._downloadPackName = nil

	local packageSetMO = OptionPackageModel.instance:getPackageSetMO(packSetName)
	local curVoiceLangs = OptionPackageModel.instance:getNeedVoiceLangList()
	local downloadListTb = packageSetMO:getDownloadInfoListTb(curVoiceLangs)

	self._adapter:setDownloder(self._downloader, self._httpWorker)
	ViewMgr.instance:openView(ViewName.OptionPackageDownloadView)
	self._downloader:start(downloadListTb, self._onDownloadFinish, self, self._adapter)
	OptionPackageModel.instance:addLocalPackSetName(packSetName)

	local download_pack_list = {}

	for lang, langTb in pairs(downloadListTb) do
		if langTb and langTb.res and #langTb.res > 0 then
			table.insert(download_pack_list, lang)
		end
	end

	local data = {}

	data.resource_type = download_pack_list

	SDKDataTrackMgr.instance:trackOptionPackConfirmDownload(data)
end

function OptionPackageController:_onDownloadFinish()
	GameFacade.showToast(ToastEnum.VersionResDownloadSuccess)
	self:_updateLocalVersion()
	ViewMgr.instance:closeView(ViewName.OptionPackageDownloadView)
end

function OptionPackageController:getLocalVersionInt(packItemName)
	if not self._initialized then
		return 0
	end

	local versionStr = self._optionalUpdateInst:GetLocalVersion(packItemName)

	if not string.nilorempty(versionStr) then
		return tonumber(versionStr)
	end

	return 0
end

function OptionPackageController:getPackItemState(packItemName, latestVersion)
	if not self._initialized then
		return OptionPackageEnum.UpdateState.AlreadyLatest
	end

	return self._optionalUpdateInst:GetPackItemState(packItemName, latestVersion)
end

function OptionPackageController:_getPackageName(packageName)
	if not self._initialized or not OptionPackageEnum.HasPackageNameDict[packageName] then
		return
	end

	local packageNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	if not tabletool.indexOf(packageNameList, packageName) then
		-- block empty
	end
end

function OptionPackageHttpWorker:againGetHttp(onFinish, finishObj)
	self._httpGetterOnFinshFunc = onFinish
	self._httpGetterOnFinshObj = finishObj

	for _, httpGetter in pairs(self._httpGetterList) do
		if not self._httpGetterFinishDict[httpGetter:getHttpId()] then
			httpGetter:start(self._onHttpGetterFinish, self)
		end
	end
end

OptionPackageController.instance = OptionPackageController.New()

return OptionPackageController
