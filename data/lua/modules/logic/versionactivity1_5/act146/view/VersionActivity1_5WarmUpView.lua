module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpView", package.seeall)

local var_0_0 = class("VersionActivity1_5WarmUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._scrollTaskTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._scrollTaskDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	arg_1_0._txtTaskContent = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward")
	arg_1_0._goWrongChannel = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._godragarea = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_dragarea")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_Title")
	arg_1_0._txtTaskTitle = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	arg_1_0._btngetreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_getreward")
	arg_1_0._imagePhoto2 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/#image_Photo2")
	arg_1_0._goguide1 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_guide1")
	arg_1_0._goguide2 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_guide2")
	arg_1_0._gomail1 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_mail1")
	arg_1_0._imageTipsBG1 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_mail1/#image_TipsBG1")
	arg_1_0._gomail2 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_mail2")
	arg_1_0._imageTipsBG2 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_mail2/#image_TipsBG2")
	arg_1_0._imagePhoto = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail1/image_Envelop/#image_Photo")
	arg_1_0._imagePhotoMask1 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask1")
	arg_1_0._imagePhotoMask2 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask2")
	arg_1_0._imagePhotoMask3 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity146Controller.instance, Activity146Event.OnEpisodeFinished, arg_2_0._onEpisodeFinished, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0._btngetreward:AddClickListener(arg_2_0._btngetrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity146Controller.instance, Activity146Event.OnEpisodeFinished, arg_3_0._onEpisodeFinished, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0._btngetreward:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._episodeItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._rewardItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._goRewardContent = gohelper.findChild(arg_4_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content")
	arg_4_0._goTaskContent = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	arg_4_0._dragAreaCanvasGroup = gohelper.onceAddComponent(arg_4_0._godragarea, typeof(UnityEngine.CanvasGroup))
	arg_4_0._viewGOCanvasGroup = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.CanvasGroup))

	local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "Middle")

	arg_4_0._middleAnim = gohelper.onceAddComponent(var_4_0, typeof(UnityEngine.Animator))
	arg_4_0._tipsBG1Anim = gohelper.onceAddComponent(arg_4_0._imageTipsBG1, typeof(UnityEngine.Animator))
	arg_4_0._tipsBG2Anim = gohelper.onceAddComponent(arg_4_0._imageTipsBG2, typeof(UnityEngine.Animator))
	arg_4_0._viewGOAnim = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))

	gohelper.setActive(arg_4_0._gomail1, false)
	gohelper.setActive(arg_4_0._gomail2, false)

	arg_4_0._episodeCanGetInfoDict = {}
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0._actId = arg_6_0.viewParam.actId

	Activity146Controller.instance:getAct146InfoFromServer(arg_6_0._actId)
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:_showDeadline()
	arg_7_0:_initEpisodeList()
	arg_7_0:_realRefreshEpisodeUI()
	arg_7_0:_refreshGuide()
	arg_7_0:_initRewards()
	Activity146Controller.instance:markHasEnterEpisode()
end

function var_0_0._showDeadline(arg_8_0)
	arg_8_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_8_0._onRefreshDeadline, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._onRefreshDeadline, arg_8_0, 60)
end

function var_0_0._onRefreshDeadline(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = ActivityModel.instance:getRemainTime(arg_9_0._actId)

	arg_9_0._txtLimitTime.text = string.format(luaLang("verionactivity1_3radioview_remaintime"), var_9_0, var_9_1)

	if var_9_0 <= 0 and var_9_1 <= 0 and var_9_2 <= 0 then
		TaskDispatcher.cancelTask(arg_9_0._onRefreshDeadline, arg_9_0)
	end
end

var_0_0.DelaySwitchPhotoTime = 0.3

function var_0_0._fakeRefreshEpisodeUI(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_0._goWrongChannel, not arg_10_2)
	gohelper.setActive(arg_10_0._godragarea, not arg_10_2)
	gohelper.setActive(arg_10_0._goTitle, arg_10_2)
	gohelper.setActive(arg_10_0._scrollTaskDesc.gameObject, arg_10_2)

	arg_10_0._dragAreaCanvasGroup.alpha = arg_10_2 and 0 or 1
	arg_10_0._txtTaskContent.text = tostring(Activity146Config.instance:getEpisodeDesc(arg_10_0._actId, arg_10_1))

	local var_10_0 = arg_10_0._isNeedDelaySwitchPhoto and var_0_0.DelaySwitchPhotoTime or 0

	arg_10_0._fakeEpisodeId = arg_10_1
	arg_10_0._fakeEpisodeState = arg_10_2

	TaskDispatcher.cancelTask(arg_10_0._delaySwitchPhoto, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._delaySwitchPhoto, arg_10_0, var_10_0)

	arg_10_0._isNeedDelaySwitchPhoto = false
end

function var_0_0._delaySwitchPhoto(arg_11_0)
	local var_11_0 = arg_11_0._fakeEpisodeId
	local var_11_1 = arg_11_0._fakeEpisodeState

	UISpriteSetMgr.instance:setV1a5WarmUpSprite(arg_11_0._imagePhoto2, "v1a5_warmup_photo" .. var_11_0)
	UISpriteSetMgr.instance:setV1a5WarmUpSprite(arg_11_0._imagePhoto, "v1a5_warmup_photo" .. var_11_0)
	gohelper.setActive(arg_11_0._imagePhotoMask1.gameObject, not var_11_1)
	gohelper.setActive(arg_11_0._imagePhotoMask2.gameObject, not var_11_1)
	gohelper.setActive(arg_11_0._imagePhotoMask3.gameObject, not var_11_1)
	gohelper.setActive(arg_11_0._gomail1, var_11_0 == 1)
	gohelper.setActive(arg_11_0._gomail2, var_11_0 ~= 1)

	local var_11_2 = var_11_0 == 1 and var_11_1
	local var_11_3 = var_11_0 == 1 and Activity146Model.instance:isEpisodeFinished(var_11_0)

	if not (arg_11_0._middleAnim:GetCurrentAnimatorStateInfo(0):IsName("open") and var_11_2) then
		if var_11_2 then
			local var_11_4 = var_11_3 and 1 or 0

			arg_11_0._middleAnim:Play("open", 0, var_11_4)
		else
			arg_11_0._middleAnim:Play("idle", 0, 0)
		end
	end

	local var_11_5 = var_11_1 and "close" or "open"

	arg_11_0._tipsBG1Anim:Play(var_11_5, 0, 0)
	arg_11_0._tipsBG2Anim:Play(var_11_5, 0, 0)
end

function var_0_0._realRefreshEpisodeUI(arg_12_0)
	local var_12_0 = Activity146Model.instance:getCurSelectedEpisode()
	local var_12_1 = Activity146Model.instance:isEpisodeFinished(var_12_0)

	arg_12_0:_fakeRefreshEpisodeUI(var_12_0, var_12_1)

	arg_12_0._txtTaskTitle.text = tostring(Activity146Config.instance:getEpisodeTitle(arg_12_0._actId, var_12_0))

	gohelper.setActive(arg_12_0._imageTipsBG1, not var_12_1)
	gohelper.setActive(arg_12_0._imageTipsBG2, not var_12_1)
end

function var_0_0._refreshGuide(arg_13_0)
	local var_13_0 = Activity146Model.instance:getCurSelectedEpisode()
	local var_13_1 = Activity146Model.instance:isEpisodeFinished(var_13_0)
	local var_13_2 = Activity146Model.instance:isEpisodeFirstEnter(var_13_0)

	gohelper.setActive(arg_13_0._goguide1, var_13_0 == 1 and not var_13_1 and var_13_2)
	gohelper.setActive(arg_13_0._goguide2, var_13_0 == 2 and not var_13_1 and var_13_2)
end

local var_0_1 = 6

function var_0_0._onEpisodeFinished(arg_14_0)
	local var_14_0 = Activity146Model.instance:getCurSelectedEpisode()

	arg_14_0:_fakeRefreshEpisodeUI(var_14_0, true)

	arg_14_0._viewGOCanvasGroup.blocksRaycasts = false

	arg_14_0:_overrideViewCloseCheckFunc()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, false)

	local var_14_1 = tostring(Activity146Config.instance:getEpisodeDesc(arg_14_0._actId, var_14_0))

	arg_14_0:_playEpisodeDesc("", var_14_1, var_0_1, arg_14_0._onPlayEpisodeDescFinished, arg_14_0)

	if var_14_0 == 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_opening)
	end
end

function var_0_0._playEpisodeDesc(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_0._tweenId then
		ZProj.TweenHelper.KillById(arg_15_0._tweenId)

		arg_15_0._tweenId = nil
	end

	local var_15_0 = GameUtil.utf8len(arg_15_2)
	local var_15_1 = GameUtil.utf8len(arg_15_1)
	local var_15_2 = arg_15_3 * (1 - (var_15_0 > 0 and var_15_1 / var_15_0 or 0))

	arg_15_0._txtTaskContent.text = arg_15_1
	arg_15_0._tweenId = ZProj.TweenHelper.DOText(arg_15_0._txtTaskContent, arg_15_2, var_15_2, arg_15_4, arg_15_5)
	arg_15_0._isPlayingEpisodeDesc = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
end

function var_0_0._onPlayEpisodeDescFinished(arg_16_0)
	arg_16_0._viewGOCanvasGroup.blocksRaycasts = true

	gohelper.setActive(arg_16_0._btngetreward.gameObject, true)

	arg_16_0._isPlayingEpisodeDesc = false

	arg_16_0:_revertViewCloseCheckFunc()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, true)
	Activity146Controller.instance:onFinishActEpisode(arg_16_0._actId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

function var_0_0._initEpisodeList(arg_17_0)
	local var_17_0 = Activity146Config.instance:getAllEpisodeConfigs(arg_17_0._actId)
	local var_17_1 = Activity146Model.instance:getCurSelectedEpisode()
	local var_17_2 = {}

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			local var_17_3 = arg_17_0:_getOrCreateEpisodeItem(iter_17_1.id)

			gohelper.setActive(var_17_3.episodeItemGo, iter_17_1 ~= nil)

			if iter_17_1 then
				var_17_3.txtDateUnSelected.text = string.format("Day.%s", iter_17_0)
				var_17_3.txtDateSelected.text = string.format("Day.%s", iter_17_0)

				local var_17_4 = Activity146Model.instance:isEpisodeUnLock(iter_17_1.id)
				local var_17_5 = iter_17_1.id == var_17_1

				gohelper.setActive(var_17_3.goDateSelected, var_17_5)
				gohelper.setActive(var_17_3.txtDateUnSelected.gameObject, not var_17_5)
				gohelper.setActive(var_17_3.goLocked, not var_17_4)
			end

			var_17_2[var_17_3] = true
		end
	end

	arg_17_0:_recycleUnUsefulEpisodeItem(var_17_2)
	ZProj.UGUIHelper.RebuildLayout(arg_17_0._goTaskContent.transform)

	arg_17_0._scrollTaskTabList.horizontalNormalizedPosition = Mathf.Lerp(0, 1, (var_17_1 - 1) / (#var_17_0 - 1))
end

function var_0_0._getOrCreateEpisodeItem(arg_18_0, arg_18_1)
	arg_18_0._episodeItemTab = arg_18_0._episodeItemTab or {}

	local var_18_0 = arg_18_0._episodeItemTab[arg_18_1]

	if not var_18_0 then
		local var_18_1 = gohelper.cloneInPlace(arg_18_0._goradiotaskitem, "taskItem" .. arg_18_1)
		local var_18_2 = gohelper.findChildText(var_18_1, "txt_DateUnSelected")
		local var_18_3 = gohelper.findChild(var_18_1, "image_Selected")
		local var_18_4 = gohelper.findChildText(var_18_1, "image_Selected/txt_DateSelected")
		local var_18_5 = gohelper.findChild(var_18_1, "image_Selected/Wave_effect2")
		local var_18_6 = gohelper.findChildImage(var_18_1, "image_Selected/image_wave")
		local var_18_7 = gohelper.findChild(var_18_1, "image_Locked")
		local var_18_8 = gohelper.findChildButtonWithAudio(var_18_1, "btn_click")

		var_18_8:AddClickListener(arg_18_0._taskItemOnClick, arg_18_0, arg_18_1)

		var_18_0 = {
			episodeItemGo = var_18_1,
			goDateSelected = var_18_3,
			txtDateSelected = var_18_4,
			imagewave = var_18_6,
			finishEffectGo = var_18_5,
			goLocked = var_18_7,
			txtDateUnSelected = var_18_2,
			click = var_18_8
		}
		arg_18_0._episodeItemTab[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0._taskItemOnClick(arg_19_0, arg_19_1)
	local var_19_0 = Activity146Model.instance:getCurSelectedEpisode()
	local var_19_1 = Activity146Model.instance:isEpisodeUnLock(arg_19_1)

	if var_19_0 ~= arg_19_1 and var_19_1 then
		arg_19_0._viewGOAnim:Play("switch", 0, 0)

		arg_19_0._isNeedDelaySwitchPhoto = true
	end

	Activity146Controller.instance:setCurSelectedEpisode(arg_19_1)

	local var_19_2 = Activity146Model.instance:getCurSelectedEpisode()
	local var_19_3 = Activity146Model.instance:isEpisodeFinished(var_19_2)

	gohelper.setActive(arg_19_0._imageTipsBG1.gameObject, not var_19_3)
	gohelper.setActive(arg_19_0._imageTipsBG2.gameObject, not var_19_3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_day_tap)
end

function var_0_0._recycleUnUsefulEpisodeItem(arg_20_0, arg_20_1)
	if arg_20_1 then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._episodeItemTab) do
			if not arg_20_1[iter_20_1] then
				gohelper.setActive(iter_20_1.episodeItemGo, false)
			end
		end
	end
end

function var_0_0._initRewards(arg_21_0)
	local var_21_0 = Activity146Model.instance:getCurSelectedEpisode()
	local var_21_1 = Activity146Config.instance:getEpisodeRewardConfig(arg_21_0._actId, var_21_0)
	local var_21_2 = Activity146Model.instance:isEpisodeFinishedButUnReceive(var_21_0)
	local var_21_3 = Activity146Model.instance:isEpisodeHasReceivedReward(var_21_0)
	local var_21_4 = {}

	if var_21_1 then
		for iter_21_0, iter_21_1 in ipairs(var_21_1) do
			local var_21_5 = arg_21_0._rewardItemTab[iter_21_0]

			if not var_21_5 then
				var_21_5 = {
					go = gohelper.cloneInPlace(arg_21_0._gorewarditem, "rewarditem" .. iter_21_0)
				}

				local var_21_6 = gohelper.findChild(var_21_5.go, "go_icon")

				var_21_5.icon = IconMgr.instance:getCommonPropItemIcon(var_21_6)
				var_21_5.goreceive = gohelper.findChild(var_21_5.go, "go_receive")
				var_21_5.gocanget = gohelper.findChild(var_21_5.go, "go_canget")
				var_21_5.hasgetAnim = gohelper.findChild(var_21_5.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))
				arg_21_0._rewardItemTab[iter_21_0] = var_21_5
			end

			gohelper.setActive(var_21_5.go, true)
			gohelper.setActive(var_21_5.goreceive, var_21_3)
			gohelper.setActive(var_21_5.gocanget, var_21_2)

			local var_21_7 = string.splitToNumber(iter_21_1, "#")

			var_21_5.icon:setMOValue(var_21_7[1], var_21_7[2], var_21_7[3])
			var_21_5.icon:setCountFontSize(42)
			var_21_5.icon:setScale(0.5)

			var_21_4[var_21_5] = true
		end
	end

	local var_21_8 = arg_21_0._episodeCanGetInfoDict[var_21_0]

	arg_21_0._episodeCanGetInfoDict[var_21_0] = var_21_2

	if var_21_8 == false and var_21_2 == true then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over)
	end

	gohelper.setActive(arg_21_0._btngetreward.gameObject, var_21_2)

	for iter_21_2, iter_21_3 in pairs(arg_21_0._rewardItemTab) do
		if not var_21_4[iter_21_3] then
			gohelper.setActive(iter_21_3.go, false)
		end
	end
end

function var_0_0._btngetrewardOnClick(arg_22_0)
	Activity146Controller.instance:tryReceiveEpisodeRewards(arg_22_0._actId)
end

function var_0_0._onDailyRefresh(arg_23_0)
	if arg_23_0._actId then
		Activity146Controller.instance:getAct146InfoFromServer(arg_23_0._actId)
	end
end

function var_0_0._overrideViewCloseCheckFunc(arg_24_0)
	local var_24_0 = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if var_24_0 then
		local var_24_1 = var_24_0.navigationView

		if var_24_1 then
			arg_24_0._originCloseCheckFunc = var_24_1._closeCheckFunc
			arg_24_0._originCloseCheckObj = var_24_1._closeCheckObj
			arg_24_0._originHomeCheckFunc = var_24_1._homeCheckFunc
			arg_24_0._originHomeCheckObj = var_24_1._homeCheckObj

			var_24_1:setCloseCheck(arg_24_0._onCloseCheckFunc, arg_24_0)
			var_24_1:setHomeCheck(arg_24_0._onCloseCheckFunc, arg_24_0)
		end
	end
end

function var_0_0._revertViewCloseCheckFunc(arg_25_0)
	local var_25_0 = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if var_25_0 then
		local var_25_1 = var_25_0.navigationView

		if var_25_1 then
			var_25_1:setCloseCheck(arg_25_0._originCloseCheckFunc, arg_25_0._originCloseCheckObj)
			var_25_1:setHomeCheck(arg_25_0._originHomeCheckFunc, arg_25_0._originHomeCheckObj)
		end
	end

	arg_25_0._originCloseCheckFunc = nil
	arg_25_0._originCloseCheckObj = nil
	arg_25_0._originHomeCheckFunc = nil
	arg_25_0._originHomeCheckObj = nil
end

function var_0_0._onCloseCheckFunc(arg_26_0)
	if arg_26_0._isPlayingEpisodeDesc then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5_WarmUpPlayingQuitCheck, MsgBoxEnum.BoxType.Yes_No, arg_26_0._messageBoxYesFunc, arg_26_0._messageBoxNoFunc, nil, arg_26_0, arg_26_0)

		if arg_26_0._tweenId then
			ZProj.TweenHelper.KillById(arg_26_0._tweenId)

			arg_26_0._tweenId = nil
		end
	end

	return not arg_26_0._isPlayingEpisodeDesc
end

function var_0_0._messageBoxYesFunc(arg_27_0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function var_0_0._messageBoxNoFunc(arg_28_0)
	local var_28_0 = Activity146Model.instance:getCurSelectedEpisode()
	local var_28_1 = tostring(Activity146Config.instance:getEpisodeDesc(arg_28_0._actId, var_28_0))
	local var_28_2 = arg_28_0._txtTaskContent.text

	arg_28_0:_playEpisodeDesc(var_28_2, var_28_1, var_0_1, arg_28_0._onPlayEpisodeDescFinished, arg_28_0)
end

function var_0_0.onClose(arg_29_0)
	arg_29_0:_revertViewCloseCheckFunc()
	Activity146Controller.instance:onCloseView()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, true)
end

function var_0_0.onDestroyView(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onRefreshDeadline, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._delaySwitchPhoto, arg_30_0)

	if arg_30_0._episodeItemTab then
		for iter_30_0, iter_30_1 in pairs(arg_30_0._episodeItemTab) do
			iter_30_1.click:RemoveClickListener()
		end
	end

	if arg_30_0._tweenId then
		ZProj.TweenHelper.KillById(arg_30_0._tweenId)

		arg_30_0._tweenId = nil
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

return var_0_0
