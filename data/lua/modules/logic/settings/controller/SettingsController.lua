module("modules.logic.settings.controller.SettingsController", package.seeall)

local var_0_0 = class("SettingsController", BaseController)

function var_0_0.openView(arg_1_0)
	local var_1_0 = {
		cateList = SettingsModel.instance:getSettingsCategoryList()
	}

	ViewMgr.instance:openView(ViewName.SettingsView, var_1_0)
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_ChangeFinish, arg_4_0._onChangeFinish, arg_4_0)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, arg_4_0._onLoginFinish, arg_4_0)
end

function var_0_0.reInit(arg_5_0)
	arg_5_0:checkRecordLogout()
end

function var_0_0.changeLangTxt(arg_6_0)
	ViewMgr.instance:closeAllViews({
		ViewName.SettingsView
	})
	ViewDestroyMgr.instance:destroyImmediately()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, arg_6_0)
	ViewMgr.instance:openView(ViewName.MainView)
	var_0_0.instance:dispatchEvent(SettingsEvent.OnChangeLangTxt)
end

function var_0_0.getStoryVoiceType(arg_7_0)
	local var_7_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.VoiceTypeKey_Story)

	if var_7_0 == nil then
		var_7_0 = GameConfig:GetCurVoiceShortcut()

		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, var_7_0)
	end

	return var_7_0
end

function var_0_0.checkRecordLogout(arg_8_0)
	logNormal("SettingsController:checkRecordLogout()")

	if not SDKMgr.isSupportRecord or not SDKMgr.instance:isSupportRecord() then
		return
	end

	if SDKMgr.instance:isRecording() then
		SDKMgr.instance:stopRecord()
	end

	SDKMgr.instance:hideRecordBubble()
end

function var_0_0._onLoginFinish(arg_9_0)
	logNormal("SettingsController:_onLoginFinish()")

	local var_9_0 = SettingsModel.instance:getRecordVideo()

	if SettingsShowHelper.canShowRecordVideo() and var_9_0 then
		SDKMgr.instance:showRecordBubble()
	end

	if SDKMgr.instance:isEmulator() then
		local var_9_1 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.EmulatorVideoCompatible, 0)
		local var_9_2 = 2

		if var_9_1 ~= var_9_2 then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.EmulatorVideoCompatible, var_9_2)
			SettingsModel.instance:setVideoCompatible(var_9_2 == 1)
		end
	end
end

function var_0_0.checkSwitchRecordVideo(arg_10_0)
	if SettingsShowHelper.canShowRecordVideo() then
		local var_10_0 = not SettingsModel.instance:getRecordVideo()

		if var_10_0 then
			if BootNativeUtil.isAndroid() then
				SDKMgr.instance:requestReadAndWritePermission()
			end

			SDKMgr.instance:showRecordBubble()
		else
			if SDKMgr.instance:isRecording() then
				GameFacade.showToast(ToastEnum.RecordingVideoSwitchOff)

				return false
			end

			SDKMgr.instance:hideRecordBubble()
		end

		SettingsModel.instance:setRecordVideo(var_10_0)

		return true
	end

	return false
end

function var_0_0._onChangeFinish(arg_11_0)
	arg_11_0._inSwitch = false
end

var_0_0.instance = var_0_0.New()

return var_0_0
