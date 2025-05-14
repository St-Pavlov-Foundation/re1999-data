module("modules.logic.settings.controller.SettingsVoicePackageController", package.seeall)

local var_0_0 = class("SettingsVoicePackageController", BaseController)

var_0_0.NotDownload = 1
var_0_0.InDownload = 2
var_0_0.NeedUpdate = 3
var_0_0.AlreadyLatest = 4
var_0_0.DownloadFailedToast = 173
var_0_0.NoEnoughDisk = 5
var_0_0.MD5CheckError = 6

function var_0_0.onInit(arg_1_0)
	arg_1_0._httpGetter = nil
	arg_1_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	arg_1_0._optionalUpdateInst = arg_1_0._optionalUpdate.Instance
	arg_1_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	arg_1_0._statHotUpdatePerList = {}
	arg_1_0._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	arg_1_0._statHotUpdatePerList[2] = {
		0.2,
		"20%"
	}
	arg_1_0._statHotUpdatePerList[3] = {
		0.4,
		"40%"
	}
	arg_1_0._statHotUpdatePerList[4] = {
		0.6,
		"60%"
	}
	arg_1_0._statHotUpdatePerList[5] = {
		0.8,
		"80%"
	}
	arg_1_0._statHotUpdatePerList[6] = {
		1,
		"100%"
	}
	arg_1_0._statHotUpdatePerNum = 6
	arg_1_0._nowStatHotUpdatePerIndex = 1
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	if not HotUpdateVoiceMgr then
		return
	end

	if not GameConfig.CanHotUpdate then
		return
	end

	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.NotEnoughDiskSpace, arg_3_0._onNotEnoughDiskSpace, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadStart, arg_3_0._onDownloadStart, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadProgressRefresh, arg_3_0._onDownloadProgressRefresh, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadPackFail, arg_3_0._onDownloadPackFail, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadPackSuccess, arg_3_0._onDownloadPackSuccess, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.PackUnZipFail, arg_3_0._onPackUnZipFail, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.PackItemStateChange, arg_3_0._onPackItemStateChange, arg_3_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, arg_3_0._onReconnectSucc, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.getLocalVersionInt(arg_5_0, arg_5_1)
	if not GameConfig.CanHotUpdate then
		return 0
	end

	if not arg_5_0._optionalUpdateInst then
		arg_5_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		arg_5_0._optionalUpdateInst = arg_5_0._optionalUpdate.Instance
	end

	local var_5_0 = arg_5_0._optionalUpdateInst:GetLocalVersion(arg_5_1)

	if not string.nilorempty(var_5_0) then
		return tonumber(var_5_0)
	end

	return 0
end

function var_0_0.switchVoiceType(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = GameConfig:GetCurVoiceShortcut()
	local var_6_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(arg_6_1)

	PlayerPrefsHelper.setNumber("StoryAudioLanType", var_6_1 - 1)
	GameLanguageMgr.instance:setVoiceTypeByStoryIndex(var_6_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, arg_6_1)
	AudioMgr.instance:changeLang(arg_6_1)
	GameConfig:SetCurVoiceType(arg_6_1)
	arg_6_0:dispatchEvent(SettingsEvent.OnChangeVoiceType)

	local var_6_2 = {
		current_language = GameConfig:GetCurLangShortcut(),
		entrance = arg_6_2 or "",
		current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList() or {},
		current_voice_pack_used = arg_6_1 or "",
		voice_pack_before = var_6_0 or ""
	}

	if arg_6_2 == "in_settings" then
		StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, var_6_2)
	else
		SDKDataTrackMgr.instance:trackVoicePackSwitch(var_6_2)
	end
end

function var_0_0.openVoicePackageView(arg_7_0)
	if not arg_7_0._httpGetter then
		arg_7_0._httpGetter = SettingVoiceHttpGetter.New()

		arg_7_0._httpGetter:start(arg_7_0._onGetVoiceInfoAndOpenView, arg_7_0)
	else
		arg_7_0:_openVoicePackageView()
	end
end

function var_0_0.RequsetVoiceInfo(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._httpGetter then
		arg_8_0._httpGetter = SettingVoiceHttpGetter.New()
	end

	arg_8_0._httpGetter:start(function()
		arg_8_0:_onGetVoiceInfo()

		if arg_8_1 then
			arg_8_1(arg_8_2)
		end
	end, arg_8_0)
end

function var_0_0.onSettingVoiceDropDown(arg_10_0)
	if not arg_10_0._httpGetter then
		arg_10_0._httpGetter = SettingVoiceHttpGetter.New()

		arg_10_0._httpGetter:start(arg_10_0._onGetVoiceInfo, arg_10_0)
	end
end

function var_0_0._onGetVoiceInfo(arg_11_0)
	local var_11_0 = arg_11_0._httpGetter:getHttpResult()

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1 = SettingsVoicePackageModel.instance:getPackInfo(iter_11_0)

		if var_11_1 then
			var_11_1:setLangInfo(iter_11_1)

			if #var_11_1.downloadResList.names > 0 then
				local var_11_2 = var_11_1.downloadResList

				arg_11_0._optionalUpdateInst:InitBreakPointInfo(var_11_2.names, var_11_2.hashs, var_11_2.orders, var_11_2.lengths)

				local var_11_3 = arg_11_0._optionalUpdateInst:GetRecvSize()
				local var_11_4 = tonumber(var_11_3)

				var_11_1:setLocalSize(var_11_4)
				arg_11_0:dispatchEvent(SettingsEvent.OnPackItemStateChange, var_11_1.lang)
			end
		end
	end
end

function var_0_0._onGetVoiceInfoAndOpenView(arg_12_0)
	arg_12_0:_onGetVoiceInfo()
	arg_12_0:_openVoicePackageView()
end

function var_0_0._openVoicePackageView(arg_13_0)
	ViewMgr.instance:openView(ViewName.SettingsVoicePackageView)
end

function var_0_0.getHttpResult(arg_14_0)
	if arg_14_0._httpGetter then
		return arg_14_0._httpGetter:getHttpResult()
	end
end

function var_0_0.getLangSize(arg_15_0, arg_15_1)
	if arg_15_0._httpGetter then
		return arg_15_0._httpGetter:getLangSize(arg_15_1)
	end
end

function var_0_0.tryDownload(arg_16_0, arg_16_1, arg_16_2)
	if ViewMgr.instance:isOpen(ViewName.SettingsVoiceDownloadView) then
		return
	end

	if arg_16_2 then
		local var_16_0, var_16_1, var_16_2 = arg_16_1:getLeftSizeMBorGB()

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DownloadVoicePack, MsgBoxEnum.BoxType.Yes_No, function()
			local var_17_0 = {}

			var_17_0.entrance = "voice_list"
			var_17_0.update_amount = arg_16_1:getLeftSizeMBNum()
			var_17_0.download_voice_pack_list = {
				arg_16_1.lang
			}
			var_17_0.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList()
			var_17_0.current_language = GameConfig:GetCurLangShortcut()
			var_17_0.current_voice_pack_used = GameConfig:GetCurVoiceShortcut()

			StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, var_17_0)
			arg_16_0:startDownload(arg_16_1)
			ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
				packItemMO = arg_16_1
			})
		end, function()
			return
		end, nil, nil, nil, nil, luaLang(arg_16_1.nameLangId), string.format("%.2f%s", var_16_0, var_16_2))
	else
		arg_16_0:startDownload(arg_16_1)
		ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
			packItemMO = arg_16_1
		})
	end
end

function var_0_0.getPackItemState(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_0._optionalUpdateInst:GetPackItemState(arg_19_1, arg_19_2)
end

function var_0_0.startDownload(arg_20_0, arg_20_1)
	logNormal("startDownload lang = " .. arg_20_1.lang .. " version = " .. arg_20_1.latestVersion)

	local var_20_0 = arg_20_1.downloadResList
	local var_20_1 = arg_20_1.download_url
	local var_20_2 = arg_20_1.download_url_bak

	arg_20_0._optionalUpdateInst:SetRemoteAssetUrl(var_20_1, var_20_2)
	arg_20_0._optionalUpdateInst:StartDownload(arg_20_1.lang, var_20_0.names, var_20_0.hashs, var_20_0.orders, var_20_0.lengths, arg_20_1.latestVersion)
	arg_20_0:_onDownloadPrepareStart(arg_20_1.lang)
end

function var_0_0.stopDownload(arg_21_0, arg_21_1)
	arg_21_0._optionalUpdateInst:StopDownload()
	arg_21_0:dispatchEvent(SettingsEvent.OnDownloadPackFail, arg_21_1.lang)
end

function var_0_0.startDownloadAll(arg_22_0)
	local var_22_0 = SettingsVoicePackageListModel.instance:getList()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_1 = iter_22_1:getStatus()

		if var_22_1 == var_0_0.NotDownload or var_22_1 == var_0_0.NeedUpdate then
			arg_22_0:startDownload(iter_22_1)
		end
	end
end

function var_0_0.deleteVoicePack(arg_23_0, arg_23_1)
	local var_23_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_23_1)
	local var_23_1 = {
		current_language = GameConfig:GetCurLangShortcut(),
		current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList(),
		current_voice_pack_used = GameConfig:GetCurVoiceShortcut(),
		voice_pack_delete = var_23_0.lang
	}

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, var_23_1)
	var_23_0:setLocalSize(0)
	arg_23_0._optionalUpdateInst:RemovePackInfo(arg_23_1)

	if arg_23_1 == "res-HD" then
		local var_23_2 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/HD"

		SLFramework.FileHelper.ClearDir(var_23_2)
		logNormal("removeVoicePack  hdDir=" .. var_23_2)
	else
		local var_23_3 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/audios/" .. SLFramework.FrameworkSettings.CurPlatformName .. "/" .. arg_23_1

		SLFramework.FileHelper.ClearDir(var_23_3)

		local var_23_4 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/" .. arg_23_1

		SLFramework.FileHelper.ClearDir(var_23_4)
		logNormal("removeVoicePack  audiosDir=" .. var_23_3)
		logNormal("removeVoicePack  voideoDir=" .. var_23_4)
	end

	ToastController.instance:showToast(183, luaLang(var_23_0.nameLangId))
	SettingsVoicePackageModel.instance:onDeleteVoicePack(arg_23_1)
	arg_23_0:dispatchEvent(SettingsEvent.OnPackItemStateChange, arg_23_1)

	if arg_23_0._httpGetter then
		arg_23_0._httpGetter:stop()

		arg_23_0._httpGetter = nil
	end

	arg_23_0:openVoicePackageView()
end

function var_0_0._onReconnectSucc(arg_24_0)
	if arg_24_0.errorCode then
		local var_24_0 = SLFramework.GameUpdate.FailError

		if arg_24_0.errorCode == var_24_0.NoEnoughDisk or arg_24_0.errorCode == var_24_0.MD5CheckError then
			arg_24_0:_cancelDownload()
		else
			arg_24_0._optionalUpdateInst:RunNextStepAction()
		end

		arg_24_0.errorCode = nil
	end
end

function var_0_0._onDownloadPrepareStart(arg_25_0, arg_25_1)
	logNormal("SettingsVoicePackageController:_onDownloadPrepareStart, packName = " .. arg_25_1)
	arg_25_0:dispatchEvent(SettingsEvent.OnDownloadPrepareStart, arg_25_1)
end

function var_0_0._onDownloadStart(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	logNormal("SettingsVoicePackageController:_onDownloadStart, packName = " .. arg_26_1 .. " curSize = " .. arg_26_2 .. " allSize = " .. arg_26_3)
	SettingsVoicePackageModel.instance:setDownloadProgress(arg_26_1, arg_26_2, arg_26_3)
	arg_26_0:dispatchEvent(SettingsEvent.OnDownloadStart, arg_26_1, arg_26_2, arg_26_3)

	local var_26_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_26_1)

	arg_26_0._nowStatHotUpdatePerIndex = 1
	arg_26_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	arg_26_0:statHotUpdate(arg_26_2 / arg_26_3, var_26_0)
end

function var_0_0._onDownloadProgressRefresh(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if LoginModel.instance:getFailCount() > 0 then
		LoginModel.instance:resetFailCount()
	end

	logNormal("SettingsVoicePackageController:_onDownloadProgressRefresh, packName = " .. arg_27_1 .. " curSize = " .. arg_27_2 .. " allSize = " .. arg_27_3)
	SettingsVoicePackageModel.instance:setDownloadProgress(arg_27_1, arg_27_2, arg_27_3)
	arg_27_0:dispatchEvent(SettingsEvent.OnDownloadProgressRefresh, arg_27_1, arg_27_2, arg_27_3)

	local var_27_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_27_1)

	if arg_27_0.initFinish == false then
		arg_27_2 = string.format("%0.2f", arg_27_2)
		arg_27_3 = string.format("%0.2f", arg_27_3)

		local var_27_1 = var_27_0.nameLangId
		local var_27_2 = {
			luaLang(var_27_1),
			arg_27_2,
			arg_27_3
		}
		local var_27_3 = GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_2"), var_27_2)

		GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, arg_27_2 / arg_27_3, var_27_3)
	end

	arg_27_0:statHotUpdate(arg_27_2 / arg_27_3, var_27_0)
end

function var_0_0.statHotUpdate(arg_28_0, arg_28_1, arg_28_2)
	for iter_28_0 = arg_28_0._nowStatHotUpdatePerIndex, arg_28_0._statHotUpdatePerNum do
		local var_28_0 = arg_28_0._statHotUpdatePerList[iter_28_0]

		if arg_28_1 >= var_28_0[1] then
			local var_28_1 = {
				step = var_28_0[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_28_0._downLoadStartTime,
				update_amount = arg_28_2:getLeftSizeMBNum(),
				download_voice_pack_list = {
					arg_28_2.lang
				}
			}

			var_28_1.result_msg = "", StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, var_28_1)
			arg_28_0._nowStatHotUpdatePerIndex = iter_28_0 + 1
		else
			break
		end
	end
end

function var_0_0._onPackItemStateChange(arg_29_0, arg_29_1)
	logNormal("SettingsVoicePackageController:_onPackItemStateChange, packName = " .. arg_29_1)
	arg_29_0:dispatchEvent(SettingsEvent.OnPackItemStateChange, arg_29_1)
end

function var_0_0._onDownloadPackSuccess(arg_30_0, arg_30_1)
	logNormal("SettingsVoicePackageController:_onDownloadPackSuccess, packName = " .. arg_30_1)
	SettingsVoicePackageModel.instance:onDownloadSucc(arg_30_1)
	arg_30_0:dispatchEvent(SettingsEvent.OnDownloadPackSuccess, arg_30_1)

	if arg_30_0.initFinish == false and arg_30_0.needUpdateMODic[arg_30_1] then
		arg_30_0.allUpdateSize = 0
		arg_30_0.alreadyUpdateSize = arg_30_0.needUpdateMODic[arg_30_1].size
		arg_30_0.needUpdateMODic[arg_30_1] = nil

		for iter_30_0, iter_30_1 in pairs(arg_30_0.needUpdateMODic) do
			arg_30_0.allUpdateSize = arg_30_0.allUpdateSize + iter_30_1.size
		end

		arg_30_0.allUpdateSize = arg_30_0.allUpdateSize / 1024 / 1024

		if arg_30_0.allUpdateSize == 0 then
			arg_30_0:_tryOptionDataInitedCallBack(true)
		end
	end
end

function var_0_0._onDownloadPackFail(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	logNormal("SettingsVoicePackageController:_onDownloadPackFail, packName = " .. arg_31_1 .. " resUrl = " .. arg_31_2 .. " failError = " .. arg_31_3)
	arg_31_0:dispatchEvent(SettingsEvent.OnDownloadPackFail, arg_31_1, arg_31_2, arg_31_3)

	local var_31_0 = SettingsVoicePackageModel.instance:getPackLangName(arg_31_1)

	if arg_31_3 == 5 then
		arg_31_0:_onNotEnoughDiskSpace(arg_31_1)
	else
		LoginModel.instance:inverseUseBackup()
		require("tolua.reflection")
		tolua.loadassembly("Assembly-CSharp")

		local var_31_1 = typeof(SLFramework.GameUpdate.OptionalUpdate)

		tolua.getfield(var_31_1, "_useReserveUrl", 36):Set(SLFramework.GameUpdate.OptionalUpdate.Instance, LoginModel.instance:getUseBackup())
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()

			local var_31_2 = arg_31_0:_getDownloadFailedTip(arg_31_3, arg_31_4)

			if arg_31_0.initFinish == false then
				MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
					arg_31_0._optionalUpdateInst:RunNextStepAction()

					arg_31_0.errorCode = nil
				end, function()
					ProjBooter.instance:quitGame()
				end, nil, nil, nil, nil, var_31_0, var_31_2)
			else
				MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", luaLang("cancel"), "CANCEL", function()
					arg_31_0._optionalUpdateInst:RunNextStepAction()

					arg_31_0.errorCode = nil
				end, function()
					arg_31_0:_cancelDownload()
				end, nil, nil, nil, nil, var_31_0, var_31_2)
			end
		else
			arg_31_0:_retryDownload()
		end
	end

	local var_31_3 = SettingsVoicePackageModel.instance:getPackInfo(arg_31_1)
	local var_31_4 = {}

	var_31_4.step = ""
	var_31_4.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_31_0._downLoadStartTime
	var_31_4.update_amount = var_31_3:getLeftSizeMBNum()
	var_31_4.download_voice_pack_list = {
		var_31_3.lang
	}
	var_31_4.result_msg = arg_31_0:_getDownloadFailedTip(arg_31_3, arg_31_4)

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, var_31_4)
end

function var_0_0._retryDownload(arg_36_0)
	arg_36_0._optionalUpdateInst:RunNextStepAction()

	arg_36_0.errorCode = nil
end

function var_0_0._getDownloadFailedTip(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = SLFramework.GameUpdate.FailError

	arg_37_1 = var_37_0.IntToEnum(arg_37_1)
	arg_37_0.errorCode = arg_37_1
	arg_37_2 = arg_37_2 or ""

	if arg_37_1 == var_37_0.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif arg_37_1 == var_37_0.NotFound then
		return booterLang("download_fail_not_found")
	elseif arg_37_1 == var_37_0.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif arg_37_1 == var_37_0.TimeOut then
		return booterLang("download_fail_time_out")
	elseif arg_37_1 == var_37_0.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif arg_37_1 == var_37_0.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(arg_37_2)
	end
end

function var_0_0._onNotEnoughDiskSpace(arg_38_0, arg_38_1)
	logNormal("SettingsVoicePackageController:_onNotEnoughDiskSpace, packName = " .. arg_38_1)
	arg_38_0:dispatchEvent(SettingsEvent.OnNotEnoughDiskSpace, arg_38_1)

	local var_38_0 = SettingsVoicePackageModel.instance:getPackLangName(arg_38_1)
	local var_38_1 = arg_38_0:_getDownloadFailedTip(var_0_0.NoEnoughDisk)

	if arg_38_0.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
			arg_38_0._optionalUpdateInst:RunNextStepAction()

			arg_38_0.errorCode = nil
		end, function()
			ProjBooter.instance:quitGame()
		end, nil, nil, nil, nil, var_38_0)
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(arg_38_1)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes, function()
			arg_38_0:_cancelDownload()
		end, nil, nil, nil, nil, nil, var_38_0)
	end
end

function var_0_0._onPackUnZipFail(arg_42_0, arg_42_1, arg_42_2)
	logNormal("SettingsVoicePackageController:_onPackUnZipFail, packName = " .. arg_42_1 .. " failReason = " .. arg_42_2)
	arg_42_0:dispatchEvent(SettingsEvent.OnPackUnZipFail, arg_42_1, arg_42_2)

	local var_42_0 = SettingsVoicePackageModel.instance:getPackLangName(arg_42_1)
	local var_42_1 = arg_42_0:_getDownloadFailedTip(var_0_0.MD5CheckError)

	if arg_42_0.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
			arg_42_0._optionalUpdateInst:RunNextStepAction()

			arg_42_0.errorCode = nil
		end, function()
			ProjBooter.instance:quitGame()
		end, nil, nil, nil, nil, var_42_0)
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(arg_42_1)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes, function()
			arg_42_0:_cancelDownload()
		end, nil, nil, nil, nil, nil, var_42_0)
	end
end

function var_0_0._onUnzipProgress(arg_46_0, arg_46_1)
	logNormal("正在解压资源包，请稍后... progress = " .. arg_46_1)

	if tostring(arg_46_1) == "nan" then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, arg_46_1, luaLang("voice_package_update_unzip"))
	arg_46_0:dispatchEvent(SettingsEvent.OnUnzipProgressRefresh, arg_46_1)
end

function var_0_0.cancelDownload(arg_47_0)
	arg_47_0:_cancelDownload()
end

function var_0_0._cancelDownload(arg_48_0)
	arg_48_0._optionalUpdateInst:StopDownload()
	ViewMgr.instance:closeView(ViewName.SettingsVoiceDownloadView)

	arg_48_0.errorCode = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
