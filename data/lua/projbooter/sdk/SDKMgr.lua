module("projbooter.sdk.SDKMgr", package.seeall)

slot0 = class("SDKMgr")
slot0.ShareContentType = {
	Text = 1,
	Image = 2,
	Web = 3,
	Video = 4
}
slot0.SharePlatform = {
	WechatMoment = 3,
	WechatFriend = 2,
	QQZone = 5,
	XiaoHongShu = 8,
	TikTok = 6,
	QQ = 4,
	SinaWeibo = 1
}
slot0.ChannelId = {
	Douyin = "107",
	QQMobile = "102"
}

function slot0.ctor(slot0)
	slot0.csharpInst = ZProj.SDKManager.Instance
	slot0._callbackList = {
		[slot0.csharpInst.initCallbackType] = slot0._initSDKCallback,
		[slot0.csharpInst.loginCallBackType] = slot0._loginCallback,
		[slot0.csharpInst.logoutCallbackType] = slot0._logoutCallback,
		[slot0.csharpInst.exitCallbackType] = slot0._exitCallback,
		[slot0.csharpInst.vistorUpGradeCallBackType] = slot0._vistorUpGradeCallBack,
		[slot0.csharpInst.socialShareCallBackType] = slot0._socialShareCallBack,
		[slot0.csharpInst.screenShotCallBackType] = slot0._screenShotCallBack,
		[slot0.csharpInst.payCallBackType] = slot0._payCallBack,
		[slot0.csharpInst.earphoneStatusChangeCallBackType] = slot0._changeEarphoneContact,
		[slot0.csharpInst.windowsModeChangedCallbackType] = slot0._windowsModeChanged,
		[slot0.csharpInst.recordVideoCallbackType] = slot0._handleRecordVideoCalled
	}

	if VersionUtil.isVersionLargeEqual("2.4.0") then
		slot0._callbackList[slot0.csharpInst.queryProductDetailsCallbackType] = slot0._handleQueryProductDetailsCalled
		slot0._callbackList[slot0.csharpInst.dataPropertiesChangeCallbackType] = slot0._handleDataPropertiesChangeCalled
		slot0._callbackList[slot0.csharpInst.readNfcCallbackType] = slot0._handleReadNfcCalled
	end

	slot0.csharpInst:AddCallback(slot0._callback, slot0)

	slot0._moduleSocialShareCallBack = nil
	slot0._moduleSocialShareCallBackObj = nil
	slot0._moduleScreenShotCallBack = nil
	slot0._moduleScreenShotCallBackObj = nil
end

function slot0._callback(slot0, slot1, ...)
	if slot0._callbackList[slot1] then
		slot2(slot0, unpack({
			...
		}))
	elseif VersionUtil.isVersionLess("2.4.0") then
		if slot1 ~= slot0.csharpInst.queryProductDetailsCallbackType and slot1 ~= slot0.csharpInst.dataPropertiesChangeCallbackType then
			if slot1 == slot0.csharpInst.readNfcCallbackType then
				-- Nothing
			end
		end
	else
		logError("SDKMgr callbackType error callbackType:", tonumber(slot1))
	end
end

function slot0.initSDK(slot0, slot1, slot2)
	if slot0._isInitSDK then
		logError("SDKMgr initSDK call repeatedly")

		return
	end

	slot0._callbackNum = 0
	slot0._isInitSDK = true
	slot0._initCallback = {
		slot1,
		slot2
	}

	slot0.csharpInst:InitSDK()
end

function slot0._initSDKCallback(slot0)
	slot0._callbackNum = slot0._callbackNum + 1

	if not slot0._initCallback then
		logError(string.format("SDKMgr initSDK callback error _isInitSDK:%s _callbackNum:%s", slot0._isInitSDK, slot0._callbackNum))

		return
	end

	slot0._initCallback = nil

	slot0:_initSDKDataTrackMgr()
	slot0._initCallback[1](slot0._initCallback[2])
end

function slot0._initSDKDataTrackMgr(slot0)
	SDKDataTrackMgr.instance:initSDKDataTrack()
	SDKDataTrackMgr.instance:getDataTrackProperties()
end

function slot0.useSimulateLogin(slot0)
	return slot0.csharpInst:UseSimulateLogin()
end

function slot0.isLogin(slot0)
	return slot0.csharpInst:IsLogin()
end

function slot0.login(slot0)
	if slot0._loginSuccess then
		return
	end

	slot0._isStartLogin = true

	slot0.csharpInst:Login()
	logNormal("SDKMgr login 请求登录")
end

function slot0.isLoginSuccess(slot0)
	return slot0._loginSuccess
end

function slot0._loginCallback(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	logNormal("SDKMgr login callback result:" .. tostring(slot1))

	if not slot0._isStartLogin then
		logNormal("SDKMgr login callback 重复收到回调，忽略掉")

		return
	end

	slot0._isStartLogin = nil
	slot0._loginSuccess = slot1

	if slot1 then
		LoginModel.instance:setChannelParam(slot3, slot4, slot5, slot6, slot7)
		LoginController.instance:login({})

		if not uv0.instance:isAdult() and uv0.instance:getUserType() == 99 then
			slot0:showMinorLoginTipDialog()
		end
	else
		logWarn("SDKMgr login fail: msg = " .. (slot2 or "nil"))
	end

	LoginController.instance:dispatchEvent(LoginEvent.OnSdkLoginReturn, slot1, slot2)
end

function slot0.logout(slot0)
	if slot0._loginSuccess then
		slot0._loginSuccess = false

		slot0.csharpInst:Logout()
	end
end

function slot0._logoutCallback(slot0, slot1, slot2)
	slot0._loginSuccess = false

	if LoginController then
		LoginController.instance:onSdkLogout()
	end
end

function slot0._exitCallback(slot0, slot1, slot2)
	if LoginController then
		LoginController.instance:dispose()
	end

	if ConnectAliveMgr then
		ConnectAliveMgr.instance:dispose()
	end
end

function slot0._vistorUpGradeCallBack(slot0, slot1, slot2)
end

function slot0._socialShareCallBack(slot0, slot1, slot2)
	if slot0._moduleSocialShareCallBack then
		slot0._moduleSocialShareCallBack(slot0._moduleSocialShareCallBackObj, slot1, slot2)
	end
end

function slot0.setSocialShareCallBack(slot0, slot1, slot2)
	slot0._moduleSocialShareCallBack = slot1
	slot0._moduleSocialShareCallBackObj = slot2
end

function slot0._screenShotCallBack(slot0, slot1, slot2)
	if slot0._moduleScreenShotCallBack then
		slot0._moduleScreenShotCallBack(slot0._moduleScreenShotCallBackObj, slot1, slot2)
	end
end

function slot0.setScreenShotCallBack(slot0, slot1, slot2)
	slot0._moduleScreenShotCallBack = slot1
	slot0._moduleScreenShotCallBackObj = slot2
end

function slot0._payCallBack(slot0, slot1, slot2)
	if slot0._modulePayCallBack then
		slot0._modulePayCallBack(slot0._modulePayCallBackObj, slot1, slot2)
	end
end

function slot0.setPayCallBack(slot0, slot1, slot2)
	slot0._modulePayCallBack = slot1
	slot0._modulePayCallBackObj = slot2
end

function slot0.showVistorPlayTimeOutDialog(slot0)
	slot0.csharpInst:CallVoidFunc("showVistorPlayTimeOutDialog")
end

function slot0.showVistorUpgradeDialog(slot0)
	slot0.csharpInst:CallVoidFunc("showVistorUpgradeDialog")
end

function slot0.showMinorLoginTipDialog(slot0)
	slot0.csharpInst:CallVoidFunc("showMinorLoginTipDialog")
end

function slot0.showMinorPlayTimeOutDialog(slot0)
	slot0.csharpInst:CallVoidFunc("showMinorPlayTimeOutDialog")
end

function slot0.showMinorLimitLoginTimeDialog(slot0)
	slot0.csharpInst:CallVoidFunc("showMinorLimitLoginTimeDialog")
end

function slot0.exitSdk(slot0)
	slot0.csharpInst:CallVoidFunc("exitSdk")
end

function slot0.destroyGame(slot0)
	slot0.csharpInst:CallVoidFunc("destroyGame")
end

function slot0.getGameCode(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getGameCode()
	end

	return slot0.csharpInst:CallGetStrFunc("getGameCode")
end

function slot0.getGameId(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getGameId()
	end

	return slot0.csharpInst:CallGetStrFunc("getGameId")
end

function slot0.getGameSdkToken(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return ""
	end

	return slot0.csharpInst:CallGetStrFunc("getGameSdkToken")
end

function slot0.getChannelId(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getChannelId()
	end

	return slot0.csharpInst:CallGetStrFunc("getChannelId")
end

function slot0.getSubChannelId(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getSubChannelId()
	end

	return slot0.csharpInst:CallGetStrFunc("getSubChannelId")
end

function slot0.getUserType(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return 99
	end

	return tonumber(slot0.csharpInst:CallGetStrFunc("getUserType"))
end

function slot0.isAdult(slot0)
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return true
	end

	return slot0.csharpInst:CallGetStrFunc("isAdult") ~= "False"
end

function slot0.setScreenLightingOff(slot0, slot1)
	if not slot1 then
		slot0.csharpInst:CallToolVoidFunc("turnOffScreenLighting")
	else
		slot0.csharpInst:CallToolVoidFunc("turnOnScreenLighting")
	end
end

function slot0.openLauncher(slot0)
	slot0.csharpInst:CallVoidFunc("sdkOpenLauncher")
end

function slot0.openCostumerService(slot0)
	slot0.csharpInst:CallVoidFuncWithParams("openCostumerService", "深蓝互动")
end

function slot0.shareMedia(slot0, slot1, slot2, slot3)
	slot0.csharpInst:ShareMedia(slot1, slot2, slot3)
end

function slot0.saveImage(slot0, slot1)
	slot0.csharpInst:SaveImage(slot1)
end

function slot0.enterGame(slot0, slot1)
	slot0.csharpInst:EnterGame(slot1)
end

function slot0.createRole(slot0, slot1)
	slot0.csharpInst:CreateRole(slot1)
end

function slot0.upgradeRole(slot0, slot1)
	slot0.csharpInst:UpgradeRole(slot1)
end

function slot0.updateRole(slot0, slot1)
	slot0.csharpInst:UpdateRole(slot1)
end

function slot0.payGoods(slot0, slot1)
	slot0.csharpInst:PayGoods(slot1)
end

function slot0.getWinPackageName(slot0)
	return slot0.csharpInst:GetWinPackageName()
end

function slot0.pcLoginForQrCode(slot0)
	slot0.csharpInst:PcLoginForQrcode()
end

function slot0.isShowUserCenter(slot0)
	return slot0.csharpInst:IsShowUserCenter()
end

function slot0.isShowUnregisterButton(slot0)
	return slot0.csharpInst:CallGetStrFunc("isShowUnregisterButton") ~= "False"
end

function slot0.isNotificationEnable(slot0)
	return slot0.csharpInst:IsNotificationEnable()
end

function slot0.openNotificationSettings(slot0)
	slot0.csharpInst:OpenNotificationSettings()
end

function slot0.unregisterSdk(slot0)
	slot0.csharpInst:CallVoidFunc("unregisterSdk")
end

function slot0.isShowShareButton(slot0)
	return slot0.csharpInst:CallGetStrFunc("isShowShareButton") ~= "False"
end

function slot0.isShowAgreementButton(slot0)
	return slot0.csharpInst:IsShowAgreementButton()
end

function slot0.isShowPcLoginButton(slot0)
	return slot0.csharpInst:IsShowPcLoginButton()
end

function slot0.showUserCenter(slot0)
	slot0.csharpInst:ShowUserCenter()
end

function slot0.isEarphoneContact(slot0)
	if slot0._isInitSDK then
		return slot0.csharpInst:IsEarphoneContact()
	end
end

function slot0.isEmulator(slot0)
	return BootNativeUtil.isAndroid() and slot0.csharpInst:IsEmulator()
end

function slot0.showAgreement(slot0)
	slot0.csharpInst:CallVoidFunc("showAgreement")
end

function slot0._changeEarphoneContact(slot0)
	if AudioMgr and AudioMgr.instance then
		AudioMgr.instance:changeEarMode()
	end
end

function slot0._windowsModeChanged(slot0, slot1, slot2)
end

function slot0._handleRecordVideoCalled(slot0, slot1, slot2)
	logNormal(string.format("_handleRecordVideoCalled code = [%s], msg = [%s]", slot1, slot2))
	ToastController.instance:showToastWithString(tostring(slot2))
end

function slot0._handleQueryProductDetailsCalled(slot0, slot1, slot2)
	logNormal(string.format("_handleQueryProductDetailsCalled code = [%s], msg = [%s]", slot1, slot2))
	ToastController.instance:showToastWithString(tostring(slot2))
end

function slot0._handleDataPropertiesChangeCalled(slot0, slot1, slot2)
	logNormal(string.format("_handleDataPropertiesChangeCalled code = [%s], msg = [%s]", slot1, slot2))
	ToastController.instance:showToastWithString(tostring(slot2))
end

function slot0._handleReadNfcCalled(slot0, slot1, slot2)
	logNormal(string.format("_handleReadNfcCalled code = [%s], msg = [%s]", slot1, slot2))

	if NFCController == nil or NFCController.instance == nil then
		logNormal("NFCController is nil")

		return
	end

	NFCController.instance:onNFCRead(slot2)
end

function slot0.requestReadAndWritePermission(slot0)
	slot0.csharpInst:RequestReadAndWritePermission()
end

function slot0.showRecordBubble(slot0)
	slot0.csharpInst:CallVoidFunc("showRecordBubble")
end

function slot0.hideRecordBubble(slot0)
	slot0.csharpInst:CallVoidFunc("hideRecordBubble")
end

function slot0.startRecord(slot0)
	slot0.csharpInst:CallVoidFunc("startRecord")
end

function slot0.stopRecord(slot0)
	slot0.csharpInst:CallVoidFunc("stopRecord")
end

function slot0.isRecording(slot0)
	return slot0.csharpInst:IsRecording()
end

function slot0.isSupportRecord(slot0)
	return slot0.csharpInst:IsSupportRecord()
end

function slot0.openVideosPage(slot0)
	slot0.csharpInst:CallVoidFunc("openVideosPage")
end

function slot0.openSoJump(slot0, slot1)
	slot0.csharpInst:CallVoidFuncWithParams("openSoJump", slot1)
end

function slot0.getUserInfo(slot0)
	return slot0.csharpInst:CallGetStrFunc("getUserInfo")
end

function slot0.getUserInfoExtraParams(slot0)
	if cjson.decode(slot0:getUserInfo()).extraJson == nil then
		return nil
	end

	return cjson.decode(slot2)
end

function slot0.restartGame(slot0)
	slot0.csharpInst:CallVoidFunc("restartGame")
end

function slot0.getSystemMediaVolume(slot0)
	return slot0.csharpInst:GetSystemMediaVolume()
end

function slot0.setSystemMediaVolume(slot0, slot1)
	slot0.csharpInst:SetSystemMediaVolume(slot1)
end

function slot0.isIgnoreFileMissing(slot0)
	if BootNativeUtil.getPackageName() == "com.shenlan.m.reverse1999.nearme.gamecenter" then
		return false
	else
		return slot0.csharpInst:IsIgnoreFileMissing()
	end
end

function slot0.isUnsupportChangeVolume(slot0)
	return slot0.csharpInst:IsUnsupportChangeVolume()
end

function slot0.getDeviceInfo(slot0)
	if not slot0._deviceInfo then
		if not string.nilorempty(slot0.csharpInst:CallGetStrFunc("getDeviceInfo")) then
			slot0._deviceInfo = cjson.decode(slot1)
		else
			slot0._deviceInfo = {}
		end
	end

	return slot0._deviceInfo
end

function slot0.getGameSdkConfig(slot0)
	if not slot0._gameSdkConfig then
		if not string.nilorempty(slot0.csharpInst:CallGetStrFunc("getGameSdkConfig")) then
			slot0._gameSdkConfig = cjson.decode(slot1)
		else
			slot0._gameSdkConfig = {}
		end
	end

	return slot0._gameSdkConfig
end

function slot0.getShowNotice(slot0)
	if slot0:getGameSdkConfig() and slot1.showButtons then
		return slot1.showButtons.Notice
	end

	return true
end

slot0.instance = slot0.New()

return slot0
