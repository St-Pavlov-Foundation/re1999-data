module("projbooter.ProjBooter", package.seeall)

local var_0_0 = class("ProjBooter")

addGlobalModule("projbooter.utils.VersionUtil", "VersionUtil")
addGlobalModule("projbooter.native.BootNativeUtil", "BootNativeUtil")
addGlobalModule("projbooter.screen.GameAdaptionBgMgr", "GameAdaptionBgMgr")
addGlobalModule("projbooter.config.BooterLoadingConfig", "BooterLoadingConfig")
addGlobalModule("projbooter.BootResMgr", "BootResMgr")
addGlobalModule("projbooter.config.UrlConfig", "UrlConfig")
addGlobalModule("projbooter.config.GameUrlConfig", "GameUrlConfig")
addGlobalModule("projbooter.config.GameChannelConfig", "GameChannelConfig")
addGlobalModule("projbooter.config.BooterLanguageConfig", "BooterLanguageConfig")
addGlobalModule("projbooter.ui.BootMsgBox", "BootMsgBox")
addGlobalModule("projbooter.ui.BootLoadingView", "BootLoadingView")
addGlobalModule("projbooter.ui.BootNoticeView", "BootNoticeView")
addGlobalModule("projbooter.ui.BootVoiceView", "BootVoiceView")
addGlobalModule("projbooter.ui.BootVersionView", "BootVersionView")
addGlobalModule("projbooter.hotupdate.HotUpdateProgress", "HotUpdateProgress")
addGlobalModule("projbooter.hotupdate.HotUpdateMgr", "HotUpdateMgr")
addGlobalModule("projbooter.hotupdate.VersionValidator", "VersionValidator")
addGlobalModule("projbooter.hotupdate.VoiceHttpGetter", "VoiceHttpGetter")
addGlobalModule("projbooter.hotupdate.VoiceDownloader", "VoiceDownloader")
addGlobalModule("projbooter.hotupdate.HotUpdateVoiceMgr", "HotUpdateVoiceMgr")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageHttpGetter", "OptionPackageHttpGetter")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageDownloader", "OptionPackageDownloader")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageHttpWorker", "OptionPackageHttpWorker")
addGlobalModule("projbooter.hotupdate.optionpackage.HotUpateOptionPackageAdapter", "HotUpateOptionPackageAdapter")
addGlobalModule("projbooter.hotupdate.HotUpdateOptionPackageMgr", "HotUpdateOptionPackageMgr")
addGlobalModule("projbooter.audio.BootAudioMgr", "BootAudioMgr")
addGlobalModule("projbooter.sdk.SDKNativeUtil", "SDKNativeUtil")
addGlobalModule("projbooter.sdk.SDKMgr", "SDKMgr")
addGlobalModule("projbooter.sdk.SDKDataTrackMgr", "SDKDataTrackMgr")
addGlobalModule("projbooter.gamepad.GamepadBooter", "GamepadBooter")

function var_0_0.start(arg_1_0)
	arg_1_0:setCrashsightUid()
	arg_1_0:intGamepad()
	arg_1_0:setSkipHotUpdate()

	if isDebugBuild then
		local var_1_0 = GameUrlConfig.getLogReportUrl()

		SLFramework.DebugView.Instance:SetLogReportUrl(var_1_0)
	end

	arg_1_0:checkWidowsBackGroundSound()
	GameResMgr:InitAbDependencies(arg_1_0.onAbDependenciesInited, arg_1_0)
end

function var_0_0.checkWidowsBackGroundSound(arg_2_0)
	if BootNativeUtil.isWindows() then
		local var_2_0 = "WWise_SL_ActivateDuringFocusLoss"

		if UnityEngine.PlayerPrefs.HasKey(var_2_0) then
			return
		end

		UnityEngine.PlayerPrefs.SetFloat(var_2_0, 1)
	end
end

function var_0_0.onAbDependenciesInited(arg_3_0)
	logNormal("ProjBooter:onAbDependenciesInited")
	BootResMgr.instance:startLoading(arg_3_0.onBootResLoaded, arg_3_0)
end

function var_0_0.setCrashsightUid(arg_4_0)
	local var_4_0 = UnityEngine.PlayerPrefs.GetString("PlayerUid")

	if not string.nilorempty(var_4_0) then
		CrashSightAgent.SetUserId(var_4_0)
	end
end

function var_0_0.intGamepad(arg_5_0)
	GamepadBooter.instance:init()
end

function var_0_0.setSkipHotUpdate(arg_6_0)
	SLFramework.GameUpdate.HotUpdateInfoMgr.LoadLocalVersion()

	arg_6_0._skipHotUpdate = not GameConfig.CanHotUpdate
end

function var_0_0.onBootResLoaded(arg_7_0)
	logNormal("ProjBooter:onBootResLoaded")
	GameAdaptionBgMgr.instance:loadAdaptionBg()
	BootMsgBox.instance:init()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))
	BootLoadingView.instance:init()
	SDKMgr.instance:initSDK(arg_7_0.onSdkInited, arg_7_0)
end

function var_0_0.onSdkInited(arg_8_0)
	logNormal("ProjBooter:onSdkInited")

	local var_8_0 = tostring(SDKMgr.instance:getDeviceInfo().deviceId)

	UnityEngine.PlayerPrefs.SetString("deviceId", var_8_0)
	logNormal("deviceId=" .. var_8_0)

	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		SDKMgr.instance:setScreenLightingOff(true)
	end

	HotUpdateVoiceMgr.instance:init()
	HotUpdateOptionPackageMgr.instance:init()

	if arg_8_0._skipHotUpdate then
		arg_8_0._hotupdateDownloadFinished = true
		arg_8_0._hotupdateFinished = true
		arg_8_0._needCopyAb = BootNativeUtil.isAndroid() and GameResMgr:CopyInnerAbToPersistPath(arg_8_0.onCopyAbRes, arg_8_0)

		arg_8_0:onUpdateFinish()

		return
	end

	arg_8_0:checkVersion()
	BootVersionView.instance:show()
end

function var_0_0.checkVersion(arg_9_0)
	if not GameResMgr.IsFromEditorDir then
		VersionValidator.instance:start(arg_9_0.onCheckVersion, arg_9_0)
	else
		arg_9_0:onCheckVersion("0.0.0", false, "", 1)
	end
end

function var_0_0.onCheckVersion(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	UpdateBeat:Add(arg_10_0._onFrame, arg_10_0)

	if arg_10_2 and BootNativeUtil.isIOS() then
		arg_10_0:loadLogicLua()

		return
	end

	local var_10_0 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local var_10_1 = string.split(var_10_0, ".")
	local var_10_2 = string.split(arg_10_1, ".")

	if HotUpdateVoiceMgr.EnableEditorDebug or var_10_1[1] == var_10_2[1] then
		HotUpdateVoiceMgr.instance:showDownload(arg_10_0.getOptionalPackageInfo, arg_10_0)
	else
		arg_10_0:startUpdate()
	end
end

function var_0_0.getOptionalPackageInfo(arg_11_0)
	logNormal("ProjBooter:getOptionalPackageInfo")
	HotUpdateOptionPackageMgr.instance:showDownload(arg_11_0.startUpdate, arg_11_0, HotUpateOptionPackageAdapter.New())
end

function var_0_0._onFrame(arg_12_0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		SDKMgr.instance:exitSdk()

		return
	end
end

function var_0_0.startUpdate(arg_13_0)
	logNormal("ProjBooter:startUpdate")

	arg_13_0._needCopyAb = BootNativeUtil.isAndroid() and GameResMgr:CopyInnerAbToPersistPath(arg_13_0.onCopyAbRes, arg_13_0)

	HotUpdateMgr.instance:start(arg_13_0.onUpdateFinish, arg_13_0, arg_13_0.onUpdateDownloadFinish, arg_13_0)
end

function var_0_0.onCopyAbRes(arg_14_0, arg_14_1)
	if arg_14_1 == -1 then
		HotUpdateMgr.instance:stop()

		local var_14_0 = {
			title = booterLang("copy_ab"),
			content = booterLang("copy_ab_error"),
			leftMsg = booterLang("exit"),
			leftCb = arg_14_0.quitGame,
			leftCbObj = arg_14_0
		}

		var_14_0.rightMsg = nil

		BootMsgBox.instance:show(var_14_0)
		BootMsgBox.instance:disable()
	else
		logNormal("ProjBooter:onCopyAbRes progress:" .. tostring(arg_14_1))

		if arg_14_0._hotupdateDownloadFinished or arg_14_0._hotupdateFinished then
			if not arg_14_0._copyProgress then
				arg_14_0._copyProgress = 0
			end

			local var_14_1 = (arg_14_1 - arg_14_0._copyProgress) / (1 - arg_14_0._copyProgress)

			BootLoadingView.instance:show(var_14_1, booterLang("unpacking"))
		else
			arg_14_0._copyProgress = arg_14_1
		end

		if arg_14_1 >= 1 then
			arg_14_0._abCopyFinished = true

			if arg_14_0._hotupdateFinished then
				arg_14_0:hotUpdateVoice()
			end
		end
	end
end

function var_0_0.onUpdateDownloadFinish(arg_15_0)
	arg_15_0._hotupdateDownloadFinished = true

	logNormal("ProjBooter:onUpdateDownloadFinish()")
end

function var_0_0.onUpdateFinish(arg_16_0)
	logNormal("ProjBooter:onUpdateFinish")

	arg_16_0._hotupdateFinished = true

	if arg_16_0._needCopyAb and not arg_16_0._abCopyFinished then
		return
	end

	arg_16_0:hotUpdateVoice()
end

function var_0_0.hotUpdateVoice(arg_17_0)
	if arg_17_0._skipHotUpdate then
		logNormal("ProjBooter:hotUpdateVoice skip")

		if HotUpdateOptionPackageMgr.EnableEditorDebug then
			arg_17_0:startUpdateOptionalPackage()

			return
		end

		arg_17_0:loadLogicLua()
	else
		logNormal("ProjBooter:hotUpdateVoice")
		HotUpdateVoiceMgr.instance:startDownload(arg_17_0.startUpdateOptionalPackage, arg_17_0)
	end
end

function var_0_0.startUpdateOptionalPackage(arg_18_0)
	logNormal("ProjBooter:startUpdateOptionalPackage")
	HotUpdateOptionPackageMgr.instance:startDownload(arg_18_0.loadLogicLua, arg_18_0)
end

function var_0_0.loadLogicLua(arg_19_0)
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTmepDir2)
	logNormal("ProjBooter:loadLogicLua")
	BootLoadingView.instance:showFixBtn()

	if not GameResMgr.NeedLoadLuaBytes then
		arg_19_0:OnLogicLuaLoaded()
		logNormal("ProjBooter:loadLogicLua, src mode, skip loading!")
	else
		LuaInterface.LuaFileUtils.Instance:LoadLogic(nil, arg_19_0.OnLogicLuaLoaded, arg_19_0)
		logNormal("ProjBooter:loadLogicLua, bytecode mode, start loading!")
	end
end

function var_0_0.OnLogicLuaLoaded(arg_20_0)
	UpdateBeat:Remove(arg_20_0._onFrame, arg_20_0)
	logNormal("ProjBooter:OnLogicLuaLoaded, start game logic!")
	addGlobalModule("modules.ProjModuleStart", "ProjModuleStart")
end

function var_0_0.quitGame(arg_21_0)
	if BootNativeUtil.isAndroid() then
		SDKMgr.instance:destroyGame()
	else
		ZProj.AudioManager.Instance:BootDispose()
		UnityEngine.Application.Quit()
	end
end

var_0_0.instance = var_0_0.New()

var_0_0.instance:start()

return var_0_0
