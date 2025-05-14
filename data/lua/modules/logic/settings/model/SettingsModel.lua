module("modules.logic.settings.model.SettingsModel", package.seeall)

local var_0_0 = class("SettingsModel", BaseModel)

var_0_0.ResolutionRatioWidthList = {
	15360,
	7680,
	3840,
	2560,
	1920,
	1600,
	1366,
	1280,
	1152,
	1024,
	800
}
var_0_0.FrameRate = {
	30,
	60,
	120,
	144
}

function var_0_0.onInit(arg_1_0)
	arg_1_0._curCategoryId = 1
	arg_1_0._categoryList = {}
	arg_1_0.showHelper = arg_1_0.showHelper or SettingsShowHelper.New()

	local var_1_0 = 80
	local var_1_1 = 100

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.FirstBootForBetaTest, 0) == 1 or not BootNativeUtil.isStandalonePlayer() or SLFramework.FrameworkSettings.IsEditor then
		arg_1_0._musicValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsMusicValue, var_1_0)
		arg_1_0._voiceValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVoiceValue, var_1_0)
		arg_1_0._effectValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEffectValue, var_1_0)
		arg_1_0._globalAudioVolume = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, var_1_1)
	else
		arg_1_0._musicValue = var_1_0
		arg_1_0._voiceValue = var_1_0
		arg_1_0._effectValue = var_1_0
		arg_1_0._globalAudioVolume = var_1_1
		arg_1_0._pushStates = {}

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.FirstBootForBetaTest, 1)
	end

	arg_1_0._musicValue = math.ceil(arg_1_0._musicValue)
	arg_1_0._voiceValue = math.ceil(arg_1_0._voiceValue)
	arg_1_0._effectValue = math.ceil(arg_1_0._effectValue)
	arg_1_0._energyMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEnergyMode, 0)

	local var_1_2 = BootNativeUtil.isAndroid() and 0 or 1

	arg_1_0._screenshotSwitch = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsScreenshotSwitch, var_1_2)
	arg_1_0._minRate = 1.3333333333333333
	arg_1_0._maxRate = 2.4

	if SLFramework.FrameworkSettings.IsEditor then
		arg_1_0._screenWidth, arg_1_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	elseif BootNativeUtil.isWindows() then
		arg_1_0:initRateAndSystemSize()
		arg_1_0:initWindowsResolution()
		arg_1_0:initResolutionRationDataList()
	else
		arg_1_0._screenWidth, arg_1_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	end

	arg_1_0.limitedRoleMO = SettingsLimitedRoleMO.New()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.limitedRoleMO:reInit()
end

function var_0_0.initRateAndSystemSize(arg_3_0)
	arg_3_0._systemScreenWidth, arg_3_0._systemScreenHeight = BootNativeUtil.getDisplayResolution()
	arg_3_0._curRate = arg_3_0._systemScreenWidth / arg_3_0._systemScreenHeight

	if arg_3_0._curRate < arg_3_0._minRate then
		arg_3_0._systemScreenHeight = arg_3_0._systemScreenWidth / arg_3_0._minRate
		arg_3_0._curRate = arg_3_0._minRate
	end

	if arg_3_0._curRate > arg_3_0._maxRate then
		arg_3_0._systemScreenWidth = arg_3_0._systemScreenHeight * arg_3_0._maxRate
		arg_3_0._curRate = arg_3_0._maxRate
	end
end

function var_0_0.initResolutionRationDataList(arg_4_0)
	arg_4_0._resolutionRatioDataList = {}

	if SLFramework.FrameworkSettings.IsEditor then
		arg_4_0:_appendResolutionData(UnityEngine.Screen.width, UnityEngine.Screen.height, false)

		return
	end

	local var_4_0 = UnityEngine.Screen.currentResolution.width

	if arg_4_0._resolutionRatioDataList and #arg_4_0._resolutionRatioDataList >= 1 and arg_4_0._resolutionRatioDataList[1] == var_4_0 then
		return
	end

	local var_4_1 = math.floor(var_4_0 / arg_4_0._curRate)

	arg_4_0:_appendResolutionData(var_4_0, var_4_1, true)

	for iter_4_0, iter_4_1 in ipairs(var_0_0.ResolutionRatioWidthList) do
		if iter_4_1 <= arg_4_0._systemScreenWidth and iter_4_1 <= var_4_0 then
			local var_4_2 = math.floor(iter_4_1 / arg_4_0._curRate)

			arg_4_0:_appendResolutionData(iter_4_1, var_4_2, false)
		end
	end

	local var_4_3, var_4_4 = arg_4_0:getCurrentDropDownIndex()

	if var_4_4 then
		local var_4_5, var_4_6, var_4_7 = arg_4_0:getCurrentResolutionWHAndIsFull()

		arg_4_0:_appendResolutionData(var_4_5, var_4_6, var_4_7)
	end
end

function var_0_0.initWindowsResolution(arg_5_0)
	if SLFramework.FrameworkSettings.IsEditor then
		arg_5_0._screenWidth, arg_5_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height

		arg_5_0:_setIsFullScreen(false)

		arg_5_0._resolutionRatio = arg_5_0:_resolutionStr(arg_5_0._screenWidth, arg_5_0._screenHeight)
	else
		arg_5_0._resolutionRatio = PlayerPrefsHelper.getString(PlayerPrefsKey.ResolutionRatio, nil)

		local var_5_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FullScreenKey, ModuleEnum.FullScreenState.On)

		arg_5_0:_setIsFullScreen(var_5_0 == ModuleEnum.FullScreenState.On)

		if arg_5_0:isFullScreen() then
			local var_5_1 = UnityEngine.Screen.currentResolution

			arg_5_0._screenWidth = var_5_1.width
			arg_5_0._screenHeight = var_5_1.height
		else
			local var_5_2 = not string.nilorempty(arg_5_0._resolutionRatio) and arg_5_0._resolutionRatio ~= "nil"
			local var_5_3 = var_5_2 and string.splitToNumber(arg_5_0._resolutionRatio, "*") or {
				1920,
				1080
			}
			local var_5_4 = UnityEngine.Screen.width

			if var_5_2 and var_5_4 <= var_5_3[1] then
				arg_5_0._screenWidth = var_5_3[1]
				arg_5_0._screenHeight = var_5_3[2]
			else
				local var_5_5 = math.floor(var_5_4 / arg_5_0._curRate)

				arg_5_0._screenWidth = var_5_4
				arg_5_0._screenHeight = var_5_5
				arg_5_0._resolutionRatio = arg_5_0:_resolutionStr(var_5_4, var_5_5)
			end
		end
	end

	arg_5_0:setResolutionRatio()
end

function var_0_0.getCurCategoryId(arg_6_0)
	return arg_6_0._curCategoryId
end

function var_0_0.setCurCategoryId(arg_7_0, arg_7_1)
	arg_7_0._curCategoryId = arg_7_1
end

function var_0_0.setSettingsCategoryList(arg_8_0, arg_8_1)
	arg_8_0._categoryList = arg_8_1
end

function var_0_0.getSettingsCategoryList(arg_9_0)
	arg_9_0._categoryList = {}

	for iter_9_0, iter_9_1 in ipairs(SettingsEnum.CategoryList) do
		if arg_9_0:canShowCategory(iter_9_1) then
			table.insert(arg_9_0._categoryList, iter_9_1)
		end
	end

	return arg_9_0._categoryList
end

function var_0_0.canShowCategory(arg_10_0, arg_10_1)
	local var_10_0 = #arg_10_1.openIds == 0 and arg_10_1.showIds == nil or false

	for iter_10_0, iter_10_1 in pairs(arg_10_1.openIds) do
		if OpenModel.instance:isFuncBtnShow(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	if not var_10_0 and arg_10_1.showIds then
		for iter_10_2, iter_10_3 in pairs(arg_10_1.showIds) do
			if arg_10_0.showHelper:canShow(iter_10_3) then
				var_10_0 = true

				break
			end
		end
	end

	if arg_10_1.hideOnGamepadModle and GamepadController.instance:isOpen() then
		var_10_0 = false
	end

	return var_10_0
end

function var_0_0.isBilibili()
	local var_11_0 = SDKMgr.instance:getChannelId()

	var_11_0 = var_11_0 and tostring(var_11_0)

	return not string.nilorempty(var_11_0) and var_11_0 == "101"
end

function var_0_0.getScreenshotSwitch(arg_12_0)
	return arg_12_0._screenshotSwitch > 0
end

function var_0_0.setScreenshotSwitch(arg_13_0, arg_13_1)
	arg_13_0._screenshotSwitch = arg_13_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsScreenshotSwitch, arg_13_0._screenshotSwitch)
end

function var_0_0.changeEnergyMode(arg_14_0)
	if arg_14_0._energyMode == 1 then
		arg_14_0._energyMode = 0

		GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_14_0:getModelGraphicsQuality())
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_14_0._frameRate)
	else
		arg_14_0._energyMode = 1

		GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEnergyMode, arg_14_0._energyMode)
end

function var_0_0.getEnergyMode(arg_15_0)
	return arg_15_0._energyMode
end

function var_0_0.getMusicValue(arg_16_0)
	return arg_16_0._musicValue
end

function var_0_0.setMusicValue(arg_17_0, arg_17_1)
	arg_17_0._musicValue = arg_17_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Music_Volume, arg_17_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsMusicValue, arg_17_0._musicValue)
end

function var_0_0.getVoiceValue(arg_18_0)
	return arg_18_0._voiceValue
end

function var_0_0.setVoiceValue(arg_19_0, arg_19_1)
	arg_19_0._voiceValue = arg_19_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Voc_Volume, arg_19_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVoiceValue, arg_19_0._voiceValue)

	if arg_19_0._voiceValue > 0 then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("no"))
	else
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("yes"))
	end
end

function var_0_0.getEffectValue(arg_20_0)
	return arg_20_0._effectValue
end

function var_0_0.setEffectValue(arg_21_0, arg_21_1)
	arg_21_0._effectValue = arg_21_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.SFX_Volume, arg_21_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEffectValue, arg_21_0._effectValue)
end

function var_0_0.getGlobalAudioVolume(arg_22_0)
	return arg_22_0._globalAudioVolume
end

function var_0_0.setGlobalAudioVolume(arg_23_0, arg_23_1)
	arg_23_0._globalAudioVolume = arg_23_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, arg_23_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, arg_23_0._globalAudioVolume)
end

function var_0_0.getRealGraphicsQuality(arg_24_0)
	return GameGlobalMgr.instance:getScreenState():getLocalQuality()
end

function var_0_0.getModelGraphicsQuality(arg_25_0)
	if not arg_25_0._graphicsQuality then
		arg_25_0._graphicsQuality = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGraphicsQuality, arg_25_0:getRecommendQuality())
	end

	return arg_25_0._graphicsQuality
end

function var_0_0.setGraphicsQuality(arg_26_0, arg_26_1)
	arg_26_0._graphicsQuality = arg_26_1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGraphicsQuality, arg_26_0._graphicsQuality)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_26_1)
end

function var_0_0.getRecommendQuality(arg_27_0)
	return HardwareUtil.getPerformanceGrade()
end

function var_0_0.getRealTargetFrameRate(arg_28_0)
	return GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
end

function var_0_0.getModelTargetFrameRate(arg_29_0)
	if not arg_29_0._frameRate then
		arg_29_0._frameRate = GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
	end

	return arg_29_0._frameRate
end

function var_0_0.setTargetFrameRate(arg_30_0, arg_30_1)
	arg_30_0._frameRate = arg_30_1

	GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_30_1)
end

function var_0_0._setIsFullScreen(arg_31_0, arg_31_1)
	arg_31_0._isFullScreen = arg_31_1 and ModuleEnum.FullScreenState.On or ModuleEnum.FullScreenState.Off
end

function var_0_0._setScreenWidthAndHeight(arg_32_0, arg_32_1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	local var_32_0 = string.splitToNumber(arg_32_1, "*")

	if var_32_0[1] > arg_32_0._systemScreenWidth or var_32_0[2] > arg_32_0._systemScreenHeight then
		GameFacade.showToast(ToastEnum.SetScreenWidthAndHeightFail)

		return false
	end

	arg_32_0._screenWidth = var_32_0[1]
	arg_32_0._screenHeight = var_32_0[2]

	arg_32_0:_setIsFullScreen(false)

	arg_32_0._resolutionRatio = arg_32_1

	arg_32_0:setResolutionRatio()

	return true
end

function var_0_0.getResolutionRatio(arg_33_0)
	return arg_33_0._resolutionRatio
end

function var_0_0.setResolutionRatio(arg_34_0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.ResolutionRatio, arg_34_0._resolutionRatio)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, arg_34_0._isFullScreen)
	ZProj.GameHelper.SetResolutionRatio(arg_34_0._screenWidth, arg_34_0._screenHeight, arg_34_0:isFullScreen())
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, arg_34_0._screenWidth, arg_34_0._screenHeight)
end

function var_0_0.getCurrentScreenResolutionRatio(arg_35_0)
	return arg_35_0._screenWidth / arg_35_0._screenHeight
end

function var_0_0.getCurrentScreenSize(arg_36_0)
	return arg_36_0._screenWidth, arg_36_0._screenHeight
end

function var_0_0.isFullScreen(arg_37_0)
	return arg_37_0._isFullScreen == ModuleEnum.FullScreenState.On
end

function var_0_0.setFullChange(arg_38_0, arg_38_1)
	arg_38_0._isFullScreen = arg_38_1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, arg_38_1)

	if arg_38_0:isFullScreen() then
		ZProj.GameHelper.SetResolutionRatio(arg_38_0._systemScreenWidth, arg_38_0._systemScreenHeight, true)
	else
		ZProj.GameHelper.SetResolutionRatio(arg_38_0._screenWidth, arg_38_0._screenHeight, false)
	end
end

function var_0_0.getScreenSizeMinRate(arg_39_0)
	return arg_39_0._minRate
end

function var_0_0.getScreenSizeMaxRate(arg_40_0)
	return arg_40_0._maxRate
end

function var_0_0.checkInitRecordVideo(arg_41_0)
	if arg_41_0._isRecordVideo ~= nil then
		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) then
		arg_41_0._isRecordVideo = 0

		return
	end

	arg_41_0._isRecordVideo = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsRecordVideo, 0)
end

function var_0_0.setRecordVideo(arg_42_0, arg_42_1)
	arg_42_0:checkInitRecordVideo()

	arg_42_0._isRecordVideo = arg_42_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsRecordVideo, arg_42_0._isRecordVideo)
end

function var_0_0.getRecordVideo(arg_43_0)
	arg_43_0:checkInitRecordVideo()

	return arg_43_0._isRecordVideo == 1
end

function var_0_0.setVideoCompatible(arg_44_0, arg_44_1)
	arg_44_0._isVideoCompatible = arg_44_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoCompatible, arg_44_0._isVideoCompatible)
end

function var_0_0.getVideoCompatible(arg_45_0)
	if arg_45_0._isVideoCompatible == nil then
		arg_45_0._isVideoCompatible = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoCompatible, 0)
	end

	return arg_45_0._isVideoCompatible == 1
end

function var_0_0.setVideoHDMode(arg_46_0, arg_46_1)
	arg_46_0._isVideoHDMode = arg_46_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoHDMode, arg_46_0._isVideoHDMode)
end

function var_0_0.getVideoHDMode(arg_47_0)
	if not PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVideoHDMode) and BootNativeUtil.isWindows() then
		arg_47_0:setVideoHDMode(true)
	end

	local var_47_0 = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if var_47_0 and var_47_0:needDownload() then
		arg_47_0:setVideoHDMode(false)
	end

	if arg_47_0._isVideoHDMode == nil then
		arg_47_0._isVideoHDMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoHDMode, 0)
	end

	return arg_47_0._isVideoHDMode == 1
end

function var_0_0.setPushState(arg_48_0, arg_48_1)
	arg_48_0._pushStates = {}

	for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
		arg_48_0._pushStates[iter_48_1.type] = {}
		arg_48_0._pushStates[iter_48_1.type].type = iter_48_1.type
		arg_48_0._pushStates[iter_48_1.type].param = iter_48_1.param
	end
end

function var_0_0.updatePushState(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_0._pushStates[arg_49_1] then
		arg_49_0._pushStates[arg_49_1] = {}
		arg_49_0._pushStates[arg_49_1].type = arg_49_1
	end

	arg_49_0._pushStates[arg_49_1].param = arg_49_2
end

function var_0_0.isPushTypeOn(arg_50_0, arg_50_1)
	local var_50_0 = SDKMgr.instance:isNotificationEnable()
	local var_50_1 = arg_50_0._pushStates[arg_50_1] and arg_50_0._pushStates[arg_50_1].param == "1"

	return var_50_0 and var_50_1
end

function var_0_0.isTypeOn(arg_51_0, arg_51_1)
	return arg_51_0._pushStates[arg_51_1] and arg_51_0._pushStates[arg_51_1].param == "1"
end

function var_0_0._resolutionStr(arg_52_0, arg_52_1, arg_52_2)
	return string.format("%s * %s", arg_52_1, arg_52_2)
end

function var_0_0.getResolutionRatioStrList(arg_53_0)
	arg_53_0:initResolutionRationDataList()

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_0._resolutionRatioDataList) do
		local var_53_1 = arg_53_0:_resolutionStr(iter_53_1.width, iter_53_1.height)

		if iter_53_1.isFullscreen then
			var_53_1 = luaLang("settings_fullscreen")
		end

		table.insert(var_53_0, var_53_1)
	end

	return var_53_0
end

function var_0_0._appendResolutionData(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	table.insert(arg_54_0._resolutionRatioDataList, {
		width = arg_54_1,
		height = arg_54_2,
		isFullscreen = arg_54_3
	})
end

function var_0_0.setScreenResolutionByIndex(arg_55_0, arg_55_1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if not arg_55_0._resolutionRatioDataList then
		return false
	end

	local var_55_0 = arg_55_0._resolutionRatioDataList[arg_55_1]

	if not var_55_0 then
		GameFacade.showToastString("error index:" .. arg_55_1)

		return false
	end

	arg_55_0._screenWidth = var_55_0.width
	arg_55_0._screenHeight = var_55_0.height

	arg_55_0:_setIsFullScreen(var_55_0.isFullscreen)

	arg_55_0._resolutionRatio = arg_55_0:_resolutionStr(arg_55_0._screenWidth, arg_55_0._screenHeight)

	arg_55_0:setResolutionRatio()

	return true
end

function var_0_0.getCurrentResolutionWHAndIsFull(arg_56_0)
	if not arg_56_0._resolutionRatio then
		arg_56_0:initWindowsResolution()
	end

	local var_56_0 = string.splitToNumber(arg_56_0._resolutionRatio, "*")

	if not var_56_0 then
		return 0, 0, false
	end

	local var_56_1 = arg_56_0:isFullScreen()

	return var_56_0[1], var_56_0[2], var_56_1
end

function var_0_0.getCurrentDropDownIndex(arg_57_0)
	local var_57_0, var_57_1, var_57_2 = arg_57_0:getCurrentResolutionWHAndIsFull()

	if var_57_2 then
		return 0
	end

	for iter_57_0, iter_57_1 in ipairs(arg_57_0._resolutionRatioDataList or {}) do
		if not iter_57_1.isFullscreen and var_57_0 == iter_57_1.width and var_57_1 == iter_57_1.height then
			return iter_57_0 - 1
		end
	end

	return 0, true
end

function var_0_0.getCurrentFrameRateIndex(arg_58_0)
	local var_58_0 = arg_58_0:getModelTargetFrameRate()

	for iter_58_0, iter_58_1 in ipairs(var_0_0.FrameRate) do
		if var_58_0 == iter_58_1 then
			return iter_58_0
		end
	end

	return 1
end

function var_0_0.setModelTargetFrameRate(arg_59_0, arg_59_1)
	local var_59_0 = var_0_0.FrameRate[arg_59_1 + 1]

	if var_59_0 then
		logNormal("设置帧率: ", var_59_0)
		arg_59_0:setTargetFrameRate(var_59_0)
	end
end

function var_0_0.isNatives(arg_60_0)
	return not arg_60_0:isOverseas()
end

function var_0_0.isOverseas(arg_61_0)
	if arg_61_0.__isOverseas == nil then
		local var_61_0 = SDKMgr.instance:getGameId()

		if tostring(var_61_0) == "50001" then
			arg_61_0.__isOverseas = false
		else
			arg_61_0.__isOverseas = true
		end
	end

	return arg_61_0.__isOverseas
end

function var_0_0.getRegion(arg_62_0)
	if arg_62_0:isNatives() then
		return RegionEnum.zh
	else
		return GameConfig:GetCurRegionType()
	end
end

function var_0_0.isZhRegion(arg_63_0)
	return arg_63_0:getRegion() == RegionEnum.zh
end

function var_0_0.isJpRegion(arg_64_0)
	return arg_64_0:getRegion() == RegionEnum.jp
end

function var_0_0.isEnRegion(arg_65_0)
	return arg_65_0:getRegion() == RegionEnum.en
end

function var_0_0.isTwRegion(arg_66_0)
	return arg_66_0:getRegion() == RegionEnum.tw
end

function var_0_0.isKrRegion(arg_67_0)
	return arg_67_0:getRegion() == RegionEnum.ko
end

function var_0_0.getRegionShortcut(arg_68_0)
	return RegionEnum.shortcutTab[arg_68_0:getRegion()] or "en"
end

function var_0_0.extractByRegion(arg_69_0, arg_69_1)
	if string.nilorempty(arg_69_1) then
		return arg_69_1
	end

	local var_69_0 = GameUtil.splitString2(arg_69_1, false)
	local var_69_1 = arg_69_0:getRegionShortcut()

	for iter_69_0, iter_69_1 in ipairs(var_69_0) do
		if iter_69_1[1] == var_69_1 then
			return iter_69_1[2]
		end
	end

	return arg_69_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
