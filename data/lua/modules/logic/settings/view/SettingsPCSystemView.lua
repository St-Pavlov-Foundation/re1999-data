module("modules.logic.settings.view.SettingsPCSystemView", package.seeall)

local var_0_0 = class("SettingsPCSystemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_blur")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_bottom")
	arg_1_0._btnfullscreenswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch")
	arg_1_0._gofullscreenoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_off")
	arg_1_0._gofullscreenon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_on")
	arg_1_0._btnframerateswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch")
	arg_1_0._golowfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	arg_1_0._gohighfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	arg_1_0._btnhigh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	arg_1_0._gohighoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	arg_1_0._gohighon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	arg_1_0._gohighrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	arg_1_0._btnmiddle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	arg_1_0._gomiddleoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	arg_1_0._gomiddleon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	arg_1_0._gomiddlerecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	arg_1_0._btnlow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	arg_1_0._golowoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	arg_1_0._golowon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	arg_1_0._golowrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch")
	arg_1_0._govideoon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_on")
	arg_1_0._govideooff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_off")

	gohelper.setActive(gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfullscreenswitch:AddClickListener(arg_2_0._btnfullscreenswitchOnClick, arg_2_0)
	arg_2_0._btnframerateswitch:AddClickListener(arg_2_0._btnframerateswitchOnClick, arg_2_0)
	arg_2_0._btnhigh:AddClickListener(arg_2_0._btnhighOnClick, arg_2_0)
	arg_2_0._btnmiddle:AddClickListener(arg_2_0._btnmiddleOnClick, arg_2_0)
	arg_2_0._btnlow:AddClickListener(arg_2_0._btnlowOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnvideo:AddClickListener(arg_2_0._btnvideoOnClick, arg_2_0)
	arg_2_0._drop:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0._dropClick:AddClickListener(function()
		arg_2_0:_refreshDropdownList()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_2_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnfullscreenswitch:RemoveClickListener()
	arg_4_0._btnframerateswitch:RemoveClickListener()
	arg_4_0._btnhigh:RemoveClickListener()
	arg_4_0._btnmiddle:RemoveClickListener()
	arg_4_0._btnlow:RemoveClickListener()
	arg_4_0._btnclose:RemoveClickListener()
	arg_4_0._btnvideo:RemoveClickListener()
	arg_4_0._drop:RemoveOnValueChanged()
	arg_4_0._dropClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goscreen = gohelper.findChild(arg_5_0.viewGO, "graphicsScroll/Viewport/Content/screen")
	arg_5_0._drop = gohelper.findChildDropdown(arg_5_0.viewGO, "graphicsScroll/Viewport/Content/screen/text/#dropResolution")
	arg_5_0._dropClick = gohelper.getClick(arg_5_0._drop.gameObject)

	arg_5_0._simageblur:LoadImage(ResUrl.getCommonIcon("full/bj_zase_tongyong"))
	arg_5_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_5_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	arg_5_0._resolutionRatioList = SettingsModel.instance:getResolutionRatioStrList()

	arg_5_0:_refreshDropdownList()
	gohelper.setActive(arg_5_0._drop.gameObject, true)
end

function var_0_0._btnfullscreenswitchOnClick(arg_6_0)
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	arg_6_0:_refreshIsFullScreenUI()
end

function var_0_0._btnframerateswitchOnClick(arg_7_0)
	local var_7_0 = SettingsModel.instance:getModelTargetFrameRate()

	if var_7_0 == ModuleEnum.TargetFrameRate.Low then
		var_7_0 = ModuleEnum.TargetFrameRate.High
	elseif var_7_0 == ModuleEnum.TargetFrameRate.High then
		var_7_0 = ModuleEnum.TargetFrameRate.Low
	end

	SettingsModel.instance:setTargetFrameRate(var_7_0)
	arg_7_0:_refreshTargetFrameRateUI()
end

function var_0_0._onValueChanged(arg_8_0, arg_8_1)
	if not SettingsModel.instance:setScreenResolutionByIndex(arg_8_1 + 1) then
		arg_8_0._drop:SetValue(arg_8_0._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	arg_8_0:_refreshIsFullScreenUI()

	arg_8_0._preSelectedIndex = arg_8_1
end

function var_0_0._btnvideoOnClick(arg_9_0)
	if SettingsModel.instance:getVideoCompatible() == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function()
			arg_9_0:_switchVideoCompatible()
		end)
	else
		arg_9_0:_switchVideoCompatible()
	end
end

function var_0_0._switchVideoCompatible(arg_11_0)
	local var_11_0 = SettingsModel.instance:getVideoCompatible()

	SettingsModel.instance:setVideoCompatible(var_11_0 == false)
	arg_11_0:_refreshVideoUI()
end

function var_0_0._btnlowOnClick(arg_12_0)
	arg_12_0:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function var_0_0._btnmiddleOnClick(arg_13_0)
	arg_13_0:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function var_0_0._btnhighOnClick(arg_14_0)
	arg_14_0:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function var_0_0._btncloseOnClick(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0._setGraphicsQuality(arg_16_0, arg_16_1)
	if SettingsModel.instance:getModelGraphicsQuality() == arg_16_1 then
		return
	end

	if arg_16_1 < SettingsModel.instance:getRecommendQuality() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function()
			arg_16_0:directSetGraphicsQuality(arg_16_1)
		end)
	else
		arg_16_0:directSetGraphicsQuality(arg_16_1)
	end
end

function var_0_0.directSetGraphicsQuality(arg_18_0, arg_18_1)
	SettingsModel.instance:setGraphicsQuality(arg_18_1)
	arg_18_0:_refreshGraphicsQualityUI()
end

function var_0_0._refreshGraphicsQualityUI(arg_19_0)
	local var_19_0 = SettingsModel.instance:getModelGraphicsQuality()

	gohelper.setActive(arg_19_0._golowselected, var_19_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_19_0._gomiddleselected, var_19_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_19_0._gohighselected, var_19_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_19_0._golowon, var_19_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_19_0._golowoff, var_19_0 ~= ModuleEnum.Performance.Low)
	gohelper.setActive(arg_19_0._gomiddleon, var_19_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_19_0._gomiddleoff, var_19_0 ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_19_0._gohighon, var_19_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_19_0._gohighoff, var_19_0 ~= ModuleEnum.Performance.High)
	gohelper.setActive(arg_19_0._goline1, var_19_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_19_0._goline2, var_19_0 == ModuleEnum.Performance.Low)
end

function var_0_0._refreshTargetFrameRateUI(arg_20_0)
	local var_20_0 = SettingsModel.instance:getModelTargetFrameRate()

	gohelper.setActive(arg_20_0._golowfps, var_20_0 == ModuleEnum.TargetFrameRate.Low)
	gohelper.setActive(arg_20_0._gohighfps, var_20_0 == ModuleEnum.TargetFrameRate.High)
end

function var_0_0._refreshIsFullScreenUI(arg_21_0)
	gohelper.setActive(arg_21_0._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(arg_21_0._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function var_0_0._refreshVideoUI(arg_22_0)
	local var_22_0 = SettingsModel.instance:getVideoCompatible()

	gohelper.setActive(arg_22_0._govideoon, var_22_0)
	gohelper.setActive(arg_22_0._govideooff, not var_22_0)
end

function var_0_0.onUpdateParam(arg_23_0)
	return
end

function var_0_0.onOpen(arg_24_0)
	NavigateMgr.instance:addEscape(ViewName.SettingsPCSystemView, arg_24_0._btncloseOnClick, arg_24_0)
	arg_24_0:_refreshUI()

	local var_24_0 = SettingsModel.instance:getRecommendQuality()

	gohelper.setActive(arg_24_0._golowrecommend, var_24_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_24_0._gomiddlerecommend, var_24_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_24_0._gohighrecommend, var_24_0 == ModuleEnum.Performance.High)
end

function var_0_0._refreshUI(arg_25_0)
	arg_25_0:_refreshGraphicsQualityUI()
	arg_25_0:_refreshTargetFrameRateUI()
	arg_25_0:_refreshIsFullScreenUI()
	arg_25_0:_refreshVideoUI()
end

function var_0_0.onClose(arg_26_0)
	if arg_26_0.viewParam and arg_26_0.viewParam.closeCallback then
		arg_26_0.viewParam.closeCallback(arg_26_0.viewParam.closeCallbackObj)
	end

	arg_26_0._simageblur:UnLoadImage()
	arg_26_0._simagetop:UnLoadImage()
	arg_26_0._simagebottom:UnLoadImage()
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

function var_0_0._refreshDropdownList(arg_28_0)
	local var_28_0 = SettingsModel.instance:getResolutionRatioStrList()

	arg_28_0._drop:ClearOptions()
	arg_28_0._drop:AddOptions(var_28_0)
	arg_28_0._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	arg_28_0._preSelectedIndex = arg_28_0._drop:GetValue()
end

return var_0_0
