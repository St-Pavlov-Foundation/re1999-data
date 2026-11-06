-- chunkname: @modules/logic/warmup_h5/view/ActivityWarmUpH5FullView.lua

local ti = table.insert
local sf = string.format
local tc = table.concat
local string_gsub = string.gsub

module("modules.logic.warmup_h5.view.ActivityWarmUpH5FullView", package.seeall)

local ActivityWarmUpH5FullView = class("ActivityWarmUpH5FullView", BaseView)

function ActivityWarmUpH5FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_langtxt")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_click")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpH5FullView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ActivityWarmUpH5FullView:removeEvents()
	self._btnclick:RemoveClickListener()
end

local kMaxRetrySendGetReqCnt = 3
local CSFileHelper = SLFramework.FileHelper
local CSSLPictureDownloader = ZProj.SLPictureDownloader
local CSSprite = UnityEngine.Sprite
local CSRect = UnityEngine.Rect
local kZeroV2 = Vector2.zero
local kDirName = "warmup_h5"

function ActivityWarmUpH5FullView:_absRootDir()
	return SLFramework.FrameworkSettings.PersistentResRootDir .. "/" .. kDirName
end

function ActivityWarmUpH5FullView:_absFileFromRoot(path)
	return self:_absRootDir() .. "/" .. path
end

function ActivityWarmUpH5FullView:_baseName(optPicUrl)
	local picUrl = optPicUrl or self:picUrl()

	if string.nilorempty(picUrl) then
		return ""
	end

	local hasExt = true

	return CSFileHelper.GetFileName(string_gsub(picUrl, "?.*", ""), hasExt)
end

function ActivityWarmUpH5FullView:_relativeToRoot(optPicUrl)
	local basename = self:_baseName(optPicUrl)

	if string.nilorempty(basename) then
		return ""
	end

	return kDirName .. "/" .. basename
end

function ActivityWarmUpH5FullView:_absFilePath(optPicUrl)
	local basename = self:_baseName(optPicUrl)

	if string.nilorempty(basename) then
		return ""
	end

	return self:_absFileFromRoot(basename)
end

function ActivityWarmUpH5FullView:_isFileExists(optPicUrl)
	local path = self:_absFilePath(optPicUrl)

	if string.nilorempty(path) then
		return false
	end

	return CSFileHelper.IsFileExists(path)
end

function ActivityWarmUpH5FullView:_deleteLocalFiles()
	CSFileHelper.ClearDir(self:_absRootDir())
end

function ActivityWarmUpH5FullView:_bDownloaded(optPicUrl)
	local picUrl = optPicUrl or self.viewContainer:getDownloadedPicUrl()

	if string.nilorempty(picUrl) then
		return false
	end

	return self:_isFileExists(picUrl)
end

function ActivityWarmUpH5FullView:_btnclickOnClick()
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = "版本H5预热页",
		[StatEnum.EventProperties.ButtonName] = "点击参与"
	})
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()
	self:_openLink()
end

function ActivityWarmUpH5FullView:_openLink()
	local baseUrl

	if self.viewContainer:bLoadResFromWebside() then
		baseUrl = self:jumpUrl()
	else
		baseUrl = self.viewContainer:getH5BaseUrl()
	end

	logNormal("[ActivityWarmUpH5FullView] jump URL:" .. tostring(baseUrl))

	if string.nilorempty(baseUrl) then
		if self.viewContainer:bLoadResFromWebside() then
			logError("[ActivityWarmUpH5FullView] - Webside Mode jump URL empty")
		else
			logError("[ActivityWarmUpH5FullView] - Non-Webside Mode jump URL empty")
		end

		return
	end

	WebViewController.instance:simpleOpenWebView(baseUrl, self._onWebViewCb, self)
end

function ActivityWarmUpH5FullView:_actId()
	return self.viewContainer:actId()
end

function ActivityWarmUpH5FullView:_editableInitView()
	self._assetItemList = self:getUserDataTb_()
	self._imgCmp = self._simagelangtxt:GetComponent(gohelper.Type_Image)
	self._simagelangtxt.enabled = false
	self._imgCmp.enabled = false
	self._txtLimitTime.text = ""
end

function ActivityWarmUpH5FullView:_onWebViewCb(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb then
		local msgParamList = string.split(msg, "#")
		local eventName = msgParamList[1]

		if eventName == "webClose" then
			ViewMgr.instance:closeView(ViewName.WebView)
		end
	end
end

function ActivityWarmUpH5FullView:onUpdateParam()
	GameUtil.loadSImage(self._simagelangtxt, self.viewContainer:getBgResUrl())
	self:_refreshTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if self.viewContainer:bLoadResFromWebside() then
		self._simagelangtxt.enabled = false
		self._imgCmp.enabled = false

		self:_retrySendReq(true)
	else
		self._imgCmp.enabled = true
		self._simagelangtxt.enabled = true
	end
end

function ActivityWarmUpH5FullView:onOpen()
	self._retrySendReqCnt = 0

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum3_1.WarmUpH5.play_ui_mingdi_h5_open)
end

function ActivityWarmUpH5FullView:_refreshTimeTick()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self:_actId())
end

function ActivityWarmUpH5FullView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityWarmUpH5FullView:onDestroyView()
	for i, assetItem in pairs(self._assetItemList) do
		if not gohelper.isNil(assetItem) then
			assetItem:Release()
		end
	end

	self:_disposeReq()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityWarmUpH5FullView:_disposeReq()
	if self._reqId then
		SLFramework.SLWebRequest.Instance:Stop(self._reqId)

		self._reqId = nil
	end
end

function ActivityWarmUpH5FullView:_reqUrl()
	local kGameId = tostring(SDKMgr.instance:getGameId())
	local kChannelId = tostring(SDKMgr.instance:getChannelId())
	local kSubChannelId = tostring(SDKMgr.instance:getSubChannelId())
	local kServerType = tostring(GameChannelConfig.getServerType())
	local kBaseUrl = GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query?"
	local strBuf = {}

	ti(strBuf, kBaseUrl)
	ti(strBuf, sf("gameId=%s", kGameId))
	ti(strBuf, sf("channelId=%s", kChannelId))
	ti(strBuf, sf("subChannelId=%s", kSubChannelId))
	ti(strBuf, sf("serverType=%s", kServerType))
	ti(strBuf, sf("timestamp=%s", ServerTime.now() * 1000))

	local reqUrl = tc(strBuf, "&")

	return reqUrl
end

function ActivityWarmUpH5FullView:_retrySendReq(bNoAddRetryCnt)
	self:_disposeReq()

	if not bNoAddRetryCnt then
		self._retrySendReqCnt = (self._retrySendReqCnt or 0) + 1
	end

	local reqUrl = self:_reqUrl()

	logNormal("[ActivityWarmUpH5FullView] reqUrl:" .. tostring(reqUrl))

	self._reqId = SLFramework.SLWebRequest.Instance:Get(reqUrl, self._onWebReqCb, self)
end

function ActivityWarmUpH5FullView:_onWebReqCb(isSuccess, jsonStr)
	if isDebugBuild then
		local tbl = {
			[1] = "[ActivityWarmUpH5FullView:_onWebReqCb] =========== begin",
			[4] = "[ActivityWarmUpH5FullView:_onWebReqCb] =========== end",
			[2] = "isSuccess: " .. tostring(isSuccess),
			[3] = "jsonStr:\n" .. tostring(jsonStr)
		}

		logWarn(tc(tbl, "\n"))
	end

	logNormal("[ActivityWarmUpH5FullView] Succ: " .. tostring(isSuccess) .. " jsonStr:\n" .. tostring(jsonStr))

	self._reqId = nil

	if isSuccess and not string.nilorempty(jsonStr) then
		self:_onSuccGetReqData(jsonStr)
	else
		self:_onFailGetReqData()
	end
end

function ActivityWarmUpH5FullView:picUrl()
	return self._respData and self._respData.picUrl or ""
end

function ActivityWarmUpH5FullView:jumpUrl()
	return self._respData and self._respData.jumpUrl or ""
end

function ActivityWarmUpH5FullView:activityId()
	return self._respData and tonumber(self._respData.activityId) or self.viewContainer:actId()
end

function ActivityWarmUpH5FullView:_onSuccGetReqData(jsonStr)
	logNormal("[ActivityWarmUpH5FullView] GET Succ Json:" .. tostring(jsonStr))

	local jsonTbl = GameUtil.jsonDecode(jsonStr)

	if not jsonTbl then
		logError("[ActivityWarmUpH5FullView] Invalid JsonStr:" .. tostring(jsonStr))

		return
	end

	local bSucc = jsonTbl.code == 200

	if bSucc then
		self._respData = jsonTbl.data

		local picUrl = self:picUrl()

		if string.nilorempty(picUrl) then
			self:_onFailGetReqData(nil, tostring(jsonStr))

			return
		end

		local bPlayerPrefsNoSave = string.nilorempty(self.viewContainer:getDownloadedPicUrl())

		if bPlayerPrefsNoSave or not self:_bDownloaded(picUrl) then
			self.viewContainer:clearDownloadedPicUrl()
			CSSLPictureDownloader.Instance:Download(picUrl, self._onSLPictureDownloaderCb, self)
		else
			self:_onLoadExistedFileFromLocal(picUrl)
		end
	else
		self:_onFailGetReqData(jsonTbl.code)
	end
end

function ActivityWarmUpH5FullView:_onFailGetReqData(optCode, optMsg)
	if optCode then
		logError("[ActivityWarmUpH5FullView] rc: " .. tostring(optCode))
	end

	if self._retrySendReqCnt < kMaxRetrySendGetReqCnt then
		self:_retrySendReq(false)
	else
		local reqUrl = self:_reqUrl()

		logError("[ActivityWarmUpH5FullView] Reach Max Retry Count!! reqUrl: " .. tostring(reqUrl) .. "\n" .. tostring(optMsg or ""))
	end
end

function ActivityWarmUpH5FullView:_onSLPictureDownloaderCb(isSuccess, csTexture2D, dataInbytes, dledPicUrl)
	if isSuccess then
		CSFileHelper.WriteAllBytesToPath(self:_absFilePath(), dataInbytes)

		if self:_isFileExists(dledPicUrl) then
			self.viewContainer:saveDownloadedPicUrl(dledPicUrl)
		else
			local saveAsPath = self:_absFilePath(dledPicUrl)

			logError("[ActivityWarmUpH5FullView] save to local file error!! dledPicUrl: " .. tostring(dledPicUrl) .. " saveAsPath: " .. tostring(saveAsPath))
		end

		self:_onSetImageSprite(csTexture2D)
	else
		logError("[ActivityWarmUpH5FullView] dl error dledPicUrl: " .. tostring(dledPicUrl))
	end
end

function ActivityWarmUpH5FullView:_onLoadExistedFileFromLocal(optPicUrl)
	local picUrl = optPicUrl or self.viewContainer:getDownloadedPicUrl()
	local persistentResUrl = self:_relativeToRoot(picUrl)

	if isDebugBuild then
		local absPath = self:_absFilePath(picUrl)
		local bExists = CSFileHelper.IsFileExists(absPath)

		assert(bExists, "[ActivityWarmUpH5FullView] File Not Found:" .. tostring(absPath))
	end

	loadPersistentRes(persistentResUrl, SLFramework.AssetType.TEXTURE, self._onLoadedPicFromLocal, self)
	self.viewContainer:saveDownloadedPicUrl(picUrl)
end

function ActivityWarmUpH5FullView:_onRetain(newAssetItem)
	newAssetItem:Retain()
	ti(self._assetItemList, newAssetItem)
end

local kMaxRetryLoadFromLocalCnt = 3
local s_retryLoadFromLocalCnt = 0

function ActivityWarmUpH5FullView:_onLoadedPicFromLocal(newAssetItem)
	if newAssetItem.IsLoadSuccess then
		self:_onRetain(newAssetItem)

		local csTexture2D = newAssetItem:GetResource()

		self:_onSetImageSprite(csTexture2D)

		s_retryLoadFromLocalCnt = 0
	else
		logError("[ActivityWarmUpH5FullView] onLoadedPicFromLocal Failed AssetItem.ResPath: " .. tostring(newAssetItem.ResPath))

		s_retryLoadFromLocalCnt = s_retryLoadFromLocalCnt + 1

		if s_retryLoadFromLocalCnt > kMaxRetryLoadFromLocalCnt then
			s_retryLoadFromLocalCnt = 0

			self.viewContainer:clearDownloadedPicUrl()
		end
	end
end

function ActivityWarmUpH5FullView:_onSetImageSprite(csTexture2D)
	if gohelper.isNil(csTexture2D) then
		if isDebugBuild then
			logError("[ActivityWarmUpH5FullView] logic error")
		end

		return
	end

	self._imgCmp.sprite = CSSprite.Create(csTexture2D, CSRect.New(0, 0, csTexture2D.width, csTexture2D.height), kZeroV2, 100, 0)
	self._imgCmp.enabled = true

	self._imgCmp:SetNativeSize()
	gohelper.setActive(self._simagelangtxt, true)
end

return ActivityWarmUpH5FullView
