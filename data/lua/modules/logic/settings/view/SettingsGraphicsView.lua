module("modules.logic.settings.view.SettingsGraphicsView", package.seeall)

local var_0_0 = class("SettingsGraphicsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnlow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	arg_1_0._golowselected = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/preview/#go_lowselected")
	arg_1_0._golowoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	arg_1_0._golowon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	arg_1_0._golowrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	arg_1_0._btnmiddle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	arg_1_0._gomiddleselected = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/preview/#go_middleselected")
	arg_1_0._gomiddleoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	arg_1_0._gomiddleon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	arg_1_0._gomiddlerecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	arg_1_0._btnhigh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	arg_1_0._gohighselected = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/preview/#go_highselected")
	arg_1_0._gohighoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	arg_1_0._gohighon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	arg_1_0._gohighrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	arg_1_0._btnenergy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn")
	arg_1_0._goenergyon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/on")
	arg_1_0._goenergyoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/off")
	arg_1_0._btnvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn")
	arg_1_0._govideoon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/on")
	arg_1_0._govideooff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/off")
	arg_1_0._videoHD = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength")
	arg_1_0._btnHdMode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn")
	arg_1_0._goHdModeOn = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/on")
	arg_1_0._goHdModeOff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/off")
	arg_1_0._golowfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	arg_1_0._gohighfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	arg_1_0._goscreen = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen")
	arg_1_0._btnfullscreenswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/#btn_fullscreenswitch")
	arg_1_0._gofullscreenon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/#btn_fullscreenswitch/#go_fullscreenon")
	arg_1_0._gofullscreenoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/#btn_fullscreenswitch/#go_fullscreenoff")
	arg_1_0._drop = gohelper.findChildDropdown(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/#dropResolution")
	arg_1_0._dropClick = gohelper.getClick(arg_1_0._drop.gameObject)
	arg_1_0._framerateDrop = gohelper.findChildDropdown(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch")
	arg_1_0._framerateDropClick = gohelper.getClick(arg_1_0._framerateDrop.gameObject)
	arg_1_0._frameTemplate = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch/Template")
	arg_1_0.verticalmode = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode")
	arg_1_0._btnVerticalmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn")
	arg_1_0._goVerticalmodeOn = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/on")
	arg_1_0._goVerticalmodeOff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/off")
	arg_1_0._goscreenshot = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/#go_screenshot")
	arg_1_0._btnshot = gohelper.findChildButtonWithAudio(arg_1_0._goscreenshot, "switch/btn")
	arg_1_0._gooffshot = gohelper.findChild(arg_1_0._goscreenshot, "switch/btn/off")
	arg_1_0._goonshot = gohelper.findChild(arg_1_0._goscreenshot, "switch/btn/on")
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline1")
	arg_1_0._goline2 = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline2")

	gohelper.setActive(gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlow:AddClickListener(arg_2_0._btnlowOnClick, arg_2_0)
	arg_2_0._btnmiddle:AddClickListener(arg_2_0._btnmiddleOnClick, arg_2_0)
	arg_2_0._btnhigh:AddClickListener(arg_2_0._btnhighOnClick, arg_2_0)
	arg_2_0._btnenergy:AddClickListener(arg_2_0._btnenergyOnClick, arg_2_0)
	arg_2_0._btnvideo:AddClickListener(arg_2_0._btnvideoOnClick, arg_2_0)
	arg_2_0._btnHdMode:AddClickListener(arg_2_0._btnvideoHDOnClick, arg_2_0)
	arg_2_0._btnVerticalmode:AddClickListener(arg_2_0._btnVerticalmodeClick, arg_2_0)

	if BootNativeUtil.isWindows() then
		arg_2_0._btnfullscreenswitch:AddClickListener(arg_2_0._btnfullscreenswitchOnClick, arg_2_0)
		arg_2_0._drop:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
		arg_2_0._dropClick:AddClickListener(function()
			arg_2_0:_refreshDropdownList()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, arg_2_0)
	end

	arg_2_0._framerateDrop:AddOnValueChanged(arg_2_0._onFrameValueChanged, arg_2_0)
	arg_2_0._framerateDropClick:AddClickListener(function()
		arg_2_0:_refreshTargetFrameRateUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_2_0)

	if GameChannelConfig.isXfsdk() and SDKNativeUtil.isShowShareButton() then
		arg_2_0._btnshot:AddClickListener(arg_2_0._btnShotOnClick, arg_2_0)
	end

	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, arg_2_0._onChangeLangTxt, arg_2_0)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeHDType, arg_2_0._refreshVideoUI, arg_2_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnlow:RemoveClickListener()
	arg_5_0._btnmiddle:RemoveClickListener()
	arg_5_0._btnhigh:RemoveClickListener()
	arg_5_0._btnenergy:RemoveClickListener()
	arg_5_0._btnvideo:RemoveClickListener()
	arg_5_0._btnHdMode:RemoveClickListener()
	arg_5_0._btnVerticalmode:RemoveClickListener()

	if BootNativeUtil.isWindows() then
		arg_5_0._btnfullscreenswitch:RemoveClickListener()
		arg_5_0._drop:RemoveOnValueChanged()
		arg_5_0._dropClick:RemoveClickListener()
	end

	arg_5_0._framerateDrop:RemoveOnValueChanged()
	arg_5_0._framerateDropClick:RemoveClickListener()

	if GameChannelConfig.isXfsdk() and SDKNativeUtil.isShowShareButton() then
		arg_5_0._btnshot:RemoveClickListener()
	end

	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, arg_5_0._onChangeLangTxt, arg_5_0)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeHDType, arg_5_0._refreshVideoUI, arg_5_0)
end

function var_0_0._btnlowOnClick(arg_6_0)
	arg_6_0:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function var_0_0._btnmiddleOnClick(arg_7_0)
	arg_7_0:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function var_0_0._btnhighOnClick(arg_8_0)
	arg_8_0:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function var_0_0._btnenergyOnClick(arg_9_0)
	SettingsModel.instance:changeEnergyMode()
	arg_9_0:_refreshEnergyUI()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeEnergyMode)
end

function var_0_0._btnvideoOnClick(arg_10_0)
	if SettingsModel.instance:getVideoCompatible() == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function()
			arg_10_0:_switchVideoCompatible()
		end)
	else
		arg_10_0:_switchVideoCompatible()
	end
end

function var_0_0._switchVideoCompatible(arg_12_0)
	local var_12_0 = SettingsModel.instance:getVideoCompatible()

	SettingsModel.instance:setVideoCompatible(var_12_0 == false)
	arg_12_0:_refreshVideoUI()
end

function var_0_0._btnvideoHDOnClick(arg_13_0)
	local var_13_0 = SettingsModel.instance:getVideoHDMode()
	local var_13_1 = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if not var_13_0 and var_13_1 and var_13_1:needDownload() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoHD, MsgBoxEnum.BoxType.Yes_No, function()
			SettingsVoicePackageController.instance:RequsetVoiceInfo(function()
				SettingsVoicePackageController.instance:tryDownload(var_13_1)
			end)
		end)
	else
		arg_13_0:_switchVideoHDMode()
	end
end

function var_0_0._btnVerticalmodeClick(arg_16_0)
	local var_16_0 = UnityEngine.QualitySettings.vSyncCount == 1

	UnityEngine.QualitySettings.vSyncCount = var_16_0 and 0 or 1

	arg_16_0:_refreshVerticalUI()
end

function var_0_0._switchVideoHDMode(arg_17_0)
	local var_17_0 = SettingsModel.instance:getVideoHDMode()

	SettingsModel.instance:setVideoHDMode(var_17_0 == false)
	arg_17_0:_refreshVideoUI()
end

function var_0_0._btnfullscreenswitchOnClick(arg_18_0)
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	arg_18_0:_refreshIsFullScreenUI()
end

function var_0_0._btnShotOnClick(arg_19_0)
	local var_19_0 = not SettingsModel.instance:getScreenshotSwitch()

	SettingsModel.instance:setScreenshotSwitch(var_19_0)
	arg_19_0:_refreshShotUI()

	if var_19_0 and BootNativeUtil.isAndroid() then
		SDKMgr.instance:requestReadAndWritePermission()
	end
end

function var_0_0._onValueChanged(arg_20_0, arg_20_1)
	if not SettingsModel.instance:setScreenResolutionByIndex(arg_20_1 + 1) then
		arg_20_0._drop:SetValue(arg_20_0._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	arg_20_0:_refreshIsFullScreenUI()

	arg_20_0._preSelectedIndex = arg_20_1
end

function var_0_0._onFrameValueChanged(arg_21_0, arg_21_1)
	SettingsModel.instance:setModelTargetFrameRate(arg_21_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function var_0_0._editableInitView(arg_22_0)
	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		arg_22_0:_refreshDropdownList()
		gohelper.setActive(arg_22_0._drop.gameObject, true)
		gohelper.setActive(arg_22_0._goscreen.gameObject, true)
	else
		gohelper.setActive(arg_22_0._goscreen.gameObject, false)
	end

	if GameChannelConfig.isXfsdk() and SDKNativeUtil.isShowShareButton() then
		gohelper.setActive(arg_22_0._goscreenshot, true)
	else
		gohelper.setActive(arg_22_0._goscreenshot, false)
	end

	arg_22_0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() + 1)
	arg_22_0:_refreshVerticalUI()
	gohelper.setActive(arg_22_0.verticalmode, BootNativeUtil.isWindows())
	gohelper.setActive(arg_22_0._videoHD, not VersionValidator.instance:isInReviewing())
end

function var_0_0._onChangeLangTxt(arg_23_0)
	arg_23_0._drop:ClearOptions()
	arg_23_0:_editableInitView()
end

function var_0_0.onUpdateParam(arg_24_0)
	arg_24_0:_refreshUI()
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0:_refreshUI()

	local var_25_0 = SettingsModel.instance:getRecommendQuality()

	gohelper.setActive(arg_25_0._golowrecommend, var_25_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_25_0._gomiddlerecommend, var_25_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_25_0._gohighrecommend, var_25_0 == ModuleEnum.Performance.High)
end

function var_0_0._refreshUI(arg_26_0)
	arg_26_0:_refreshGraphicsQualityUI()
	arg_26_0:_refreshTargetFrameRateUI()
	arg_26_0:_refreshIsFullScreenUI()
	arg_26_0:_refreshShotUI()
	arg_26_0:_refreshEnergyUI()
	arg_26_0:_refreshVideoUI()
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

function var_0_0._setGraphicsQuality(arg_29_0, arg_29_1)
	if SettingsModel.instance:getModelGraphicsQuality() == arg_29_1 then
		return
	end

	if arg_29_1 < SettingsModel.instance:getRecommendQuality() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function()
			arg_29_0:directSetGraphicsQuality(arg_29_1)
		end)
	else
		arg_29_0:directSetGraphicsQuality(arg_29_1)
	end
end

function var_0_0.directSetGraphicsQuality(arg_31_0, arg_31_1)
	SettingsModel.instance:setGraphicsQuality(arg_31_1)
	arg_31_0:_refreshGraphicsQualityUI()
end

function var_0_0._refreshGraphicsQualityUI(arg_32_0)
	local var_32_0 = SettingsModel.instance:getModelGraphicsQuality()

	gohelper.setActive(arg_32_0._golowselected, var_32_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_32_0._gomiddleselected, var_32_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_32_0._gohighselected, var_32_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_32_0._golowon, var_32_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_32_0._golowoff, var_32_0 ~= ModuleEnum.Performance.Low)
	gohelper.setActive(arg_32_0._gomiddleon, var_32_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_32_0._gomiddleoff, var_32_0 ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_32_0._gohighon, var_32_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_32_0._gohighoff, var_32_0 ~= ModuleEnum.Performance.High)
	gohelper.setActive(arg_32_0._goline1, var_32_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_32_0._goline2, var_32_0 == ModuleEnum.Performance.Low)
end

function var_0_0._refreshIsFullScreenUI(arg_33_0)
	gohelper.setActive(arg_33_0._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(arg_33_0._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function var_0_0._refreshShotUI(arg_34_0)
	local var_34_0 = SettingsModel.instance:getScreenshotSwitch()

	gohelper.setActive(arg_34_0._gooffshot, not var_34_0)
	gohelper.setActive(arg_34_0._goonshot, var_34_0)
end

function var_0_0._refreshEnergyUI(arg_35_0)
	local var_35_0 = SettingsModel.instance:getEnergyMode()

	gohelper.setActive(arg_35_0._goenergyon, var_35_0 == 1)
	gohelper.setActive(arg_35_0._goenergyoff, var_35_0 == 0)
end

function var_0_0._refreshVideoUI(arg_36_0)
	local var_36_0 = SettingsModel.instance:getVideoCompatible()
	local var_36_1 = SettingsModel.instance:getVideoHDMode()

	gohelper.setActive(arg_36_0._govideoon, var_36_0)
	gohelper.setActive(arg_36_0._govideooff, not var_36_0)
	gohelper.setActive(arg_36_0._goHdModeOn, var_36_1)
	gohelper.setActive(arg_36_0._goHdModeOff, not var_36_1)
end

function var_0_0._refreshVerticalUI(arg_37_0)
	local var_37_0 = UnityEngine.QualitySettings.vSyncCount == 1

	gohelper.setActive(arg_37_0._goVerticalmodeOn, var_37_0)
	gohelper.setActive(arg_37_0._goVerticalmodeOff, not var_37_0)
end

function var_0_0._refreshDropdownList(arg_38_0)
	local var_38_0 = SettingsModel.instance:getResolutionRatioStrList()

	arg_38_0._drop:ClearOptions()
	arg_38_0._drop:AddOptions(var_38_0)
	arg_38_0._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	arg_38_0._preSelectedIndex = arg_38_0._drop:GetValue()
end

function var_0_0._refreshTargetFrameRateUI(arg_39_0)
	local var_39_0 = SettingsModel.instance.FrameRate
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if not BootNativeUtil.isWindows() and iter_39_1 > 60 then
			break
		end

		local var_39_2 = tostring(iter_39_1)

		table.insert(var_39_1, var_39_2)
	end

	arg_39_0._framerateDrop:ClearOptions()
	arg_39_0._framerateDrop:AddOptions(var_39_1)

	local var_39_3 = #var_39_1 * 73

	recthelper.setHeight(arg_39_0._frameTemplate.transform, var_39_3)
	arg_39_0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() - 1)

	arg_39_0._framerateDropIndex = arg_39_0._framerateDrop:GetValue()

	if arg_39_0._framerateDropIndex == 0 then
		SettingsModel.instance:setModelTargetFrameRate(0)
	end

	local var_39_4 = gohelper.findChild(arg_39_0._framerateDrop.gameObject, "Dropdown List")

	if var_39_4 then
		local var_39_5 = gohelper.findChild(var_39_4, "Viewport/Content")

		if var_39_5 then
			local var_39_6 = var_39_5.transform:GetChild(arg_39_0._framerateDropIndex + 1)

			if var_39_6 then
				local var_39_7 = gohelper.findChild(var_39_6.gameObject, "BG")

				if var_39_7 then
					gohelper.setActive(var_39_7, true)
				end
			end
		end
	end
end

return var_0_0
