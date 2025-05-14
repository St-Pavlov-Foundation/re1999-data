module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleView", package.seeall)

local var_0_0 = class("VersionActivity1_6_BossScheduleView", BaseView)
local var_0_1 = 1.5
local var_0_2 = {
	Content = 2,
	ProgressBar = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_Reward")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	arg_1_0._goGrayLine = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	arg_1_0._goNormalLine = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	arg_1_0._txtProgress = gohelper.findChildText(arg_1_0.viewGO, "Root/ProgressTip/#txt_Progress")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._txtbestProgress = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Progress")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._scrollRewardGo = arg_6_0._scrollReward.gameObject
	arg_6_0._goGraylineTran = arg_6_0._goGrayLine.transform
	arg_6_0._goNormallineTran = arg_6_0._goNormalLine.transform
	arg_6_0._goContentTran = arg_6_0._goContent.transform
	arg_6_0._rectViewPortTran = gohelper.findChild(arg_6_0._scrollRewardGo, "Viewport").transform
	arg_6_0._hLayoutGroup = arg_6_0._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_6_0._goGraylinePosX = recthelper.getAnchorX(arg_6_0._goGraylineTran)

	arg_6_0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))

	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._scrollRewardGo)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBeginHandler, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEndHandler, arg_6_0)

	arg_6_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_6_0._scrollRewardGo, DungeonMapEpisodeAudio, arg_6_0._scrollReward)
	arg_6_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_6_0._scrollRewardGo)

	arg_6_0._touch:AddClickDownListener(arg_6_0._onClickDownHandler, arg_6_0)
	arg_6_0._scrollReward:AddOnValueChanged(arg_6_0._onScrollChange, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(arg_6_0._goContentTran, 0)

	arg_6_0._listStaticData = {}
end

function var_0_0._onDragBeginHandler(arg_7_0)
	arg_7_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_8_0)
	arg_8_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_9_0)
	arg_9_0._audioScroll:onClickDown()
end

function var_0_0._onScrollChange(arg_10_0, arg_10_1)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_setListStaticData(0, 0, 0)
	VersionActivity1_6ScheduleViewListModel.instance:setStaticData(arg_12_0._listStaticData)

	local var_12_0 = VersionActivity1_6DungeonBossModel.instance:getTotalScore()

	arg_12_0._isAutoClaim, arg_12_0._lastRewardIndex, arg_12_0._claimRewardIndex = VersionActivity1_6DungeonBossModel.instance:checkAbleGetReward(var_12_0)

	if arg_12_0._isAutoClaim then
		arg_12_0:_setListStaticData(0, arg_12_0._lastRewardIndex + 1, arg_12_0._claimRewardIndex)
	end

	arg_12_0:_refresh()
end

function var_0_0._setListStaticData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._listStaticData.curIndex = arg_13_1 or 0
	arg_13_0._listStaticData.fromIndex = arg_13_2 or 0
	arg_13_0._listStaticData.toIndex = arg_13_3 or 0
end

function var_0_0.onOpenFinish(arg_14_0)
	arg_14_0:_openTweenStart()
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0._isAutoClaim then
		arg_15_0:_openTweenFinishInner()
	end
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagePanelBG:UnLoadImage()
	arg_16_0._scrollReward:RemoveOnValueChanged()
	arg_16_0:_deleteProgressTween()
	arg_16_0:_deleteContentTween()
	GameUtil.onDestroyViewMemberList(arg_16_0, "_itemList")

	if arg_16_0._drag then
		arg_16_0._drag:RemoveDragBeginListener()
		arg_16_0._drag:RemoveDragEndListener()
	end

	arg_16_0._drag = nil

	if arg_16_0._touch then
		arg_16_0._touch:RemoveClickDownListener()
	end

	arg_16_0._touch = nil

	if arg_16_0._audioScroll then
		arg_16_0._audioScroll:onDestroy()
	end

	arg_16_0._audioScroll = nil
end

function var_0_0._deleteProgressTween(arg_17_0)
	GameUtil.onDestroyViewMember_TweenId(arg_17_0, "_progressBarTweenId")
end

function var_0_0._deleteContentTween(arg_18_0)
	GameUtil.onDestroyViewMember_TweenId(arg_18_0, "_contentTweenId")
end

function var_0_0._refresh(arg_19_0)
	local var_19_0 = VersionActivity1_6DungeonBossModel.instance:getScheduleViewRewardList()
	local var_19_1 = {}
	local var_19_2 = Activity149Config.instance:getBossRewardCfgList()
	local var_19_3 = VersionActivity1_6DungeonBossModel.instance:getAleadyGotBonusIds()

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		if not var_19_0[iter_19_0].isGot then
			var_19_1[#var_19_1 + 1] = iter_19_0
		end
	end

	arg_19_0._dataList = var_19_0

	recthelper.setWidth(arg_19_0._goContentTran, arg_19_0:_calcHLayoutContentMaxWidth(#var_19_0))
	arg_19_0:_initItemList(var_19_0)
	arg_19_0:_refreshContentOffset(arg_19_0._lastRewardIndex)
	arg_19_0:_refreshBestProgress()
end

function var_0_0._createScheduleItem(arg_20_0)
	local var_20_0 = arg_20_0.viewContainer:getListScrollParam()
	local var_20_1 = var_20_0.cellClass
	local var_20_2 = arg_20_0.viewContainer:getResInst(var_20_0.prefabUrl, arg_20_0._goContent, var_20_1.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_20_2, var_20_1)
end

function var_0_0._initItemList(arg_21_0, arg_21_1)
	if arg_21_0._itemList then
		return
	end

	arg_21_0._itemList = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_0 = arg_21_0:_createScheduleItem()

		var_21_0._index = iter_21_0

		var_21_0:setData(iter_21_1)
		table.insert(arg_21_0._itemList, var_21_0)
	end
end

function var_0_0._openTweenStart(arg_22_0)
	arg_22_0._openedTweens = {
		[var_0_2.ProgressBar] = true,
		[var_0_2.Content] = true
	}

	arg_22_0:_tweenContent()
	arg_22_0:_tweenProgress()
end

function var_0_0._tweenContent(arg_23_0)
	arg_23_0:_deleteContentTween()

	if not arg_23_0._isAutoClaim then
		arg_23_0:_openTweenFinish(var_0_2.Content)

		return
	end

	local var_23_0 = arg_23_0._claimRewardIndex
	local var_23_1 = -recthelper.getAnchorX(arg_23_0._goContentTran)
	local var_23_2 = arg_23_0:_calcHorizontalLayoutPixel(var_23_0)

	if math.abs(var_23_1 - var_23_2) < 0.1 then
		arg_23_0:_openTweenFinish(var_0_2.Content)

		return
	end

	arg_23_0._contentTweenId = ZProj.TweenHelper.DOTweenFloat(var_23_1, var_23_2, var_0_1, arg_23_0._contentTweenUpdateCb, arg_23_0._contentTweenFinishedCb, arg_23_0, nil, EaseType.Linear)
end

function var_0_0._openTweenFinish(arg_24_0, arg_24_1)
	arg_24_0._openedTweens[arg_24_1] = nil

	if next(arg_24_0._openedTweens) then
		return
	end

	arg_24_0:_openTweenFinishInner()
end

function var_0_0._contentTweenUpdateCb(arg_25_0, arg_25_1)
	recthelper.setAnchorX(arg_25_0._goContentTran, -arg_25_1)
end

function var_0_0._contentTweenFinishedCb(arg_26_0)
	arg_26_0:_openTweenFinish(var_0_2.Content)
end

function var_0_0._tweenProgress(arg_27_0)
	arg_27_0:_deleteProgressTween()

	local var_27_0 = VersionActivity1_6DungeonBossModel.instance
	local var_27_1 = var_27_0:getScorePrefValue()
	local var_27_2 = var_27_0:getTotalScore()

	if var_27_2 == 0 then
		arg_27_0:_progressBarTweenUpdateCb(0)
	end

	if math.abs(var_27_1 - var_27_2) < 0.1 then
		local var_27_3 = Activity149Config.instance:getBossRewardMaxScore()

		arg_27_0:_refreshProgress(var_27_2, var_27_3)
		arg_27_0:_openTweenFinish(var_0_2.ProgressBar)

		return
	end

	var_27_0:setScorePrefValue(var_27_2)

	arg_27_0._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(var_27_1, var_27_2, var_0_1, arg_27_0._progressBarTweenUpdateCb, arg_27_0._progressBarTweenFinishedCb, arg_27_0, nil, EaseType.Linear)
end

function var_0_0._progressBarTweenUpdateCb(arg_28_0, arg_28_1)
	arg_28_1 = math.floor(arg_28_1)

	local var_28_0 = Activity149Config.instance:getBossRewardMaxScore()

	arg_28_0:_refreshProgress(arg_28_1, var_28_0)
end

function var_0_0._progressBarTweenFinishedCb(arg_29_0)
	arg_29_0:_openTweenFinish(var_0_2.ProgressBar)
end

function var_0_0._openTweenFinishInner(arg_30_0)
	if not arg_30_0._isAutoClaim then
		return
	end

	arg_30_0._isAutoClaim = false

	VersionActivity1_6DungeonRpc.instance:sendAct149GetScoreRewardsRequest()
end

function var_0_0._refreshProgress(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.viewContainer:getListScrollParam().cellWidth
	local var_31_1 = arg_31_0:_getCellSpaceH()
	local var_31_2 = arg_31_0._goGraylinePosX
	local var_31_3 = arg_31_0._hLayoutGroup.padding.left + var_31_0 / 2
	local var_31_4 = var_31_1 + var_31_0
	local var_31_5, var_31_6 = Activity149Config.instance:calRewardProgressWidth(arg_31_1, var_31_1, var_31_0, var_31_3, var_31_4, var_31_2, -var_31_2)

	recthelper.setWidth(arg_31_0._goGraylineTran, var_31_6)
	recthelper.setWidth(arg_31_0._goNormallineTran, var_31_5)

	arg_31_0._txtProgress.text = string.format("<color=#b34a16>%s</color>/%s", arg_31_1, arg_31_2)
end

function var_0_0._refreshBestProgress(arg_32_0)
	local var_32_0 = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()

	arg_32_0._txtbestProgress.text = var_32_0
end

function var_0_0._refreshContentOffset(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:_calcHorizontalLayoutPixel(arg_33_1)

	recthelper.setAnchorX(arg_33_0._goContentTran, -var_33_0)
end

local var_0_3 = 200

function var_0_0._calcHorizontalLayoutPixel(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:_getCellSpaceH()
	local var_34_1 = arg_34_0._hLayoutGroup.padding.left
	local var_34_2 = recthelper.getWidth(arg_34_0._goContentTran)
	local var_34_3 = math.max(0, var_34_2)

	if arg_34_1 <= 1 then
		return 0
	end

	return math.min(var_34_3, (arg_34_1 - 1) * (var_34_0 + var_0_3) + var_34_1)
end

function var_0_0._getCellSpaceH(arg_35_0)
	return arg_35_0._hLayoutGroup.spacing
end

function var_0_0._calcHLayoutContentMaxWidth(arg_36_0, arg_36_1)
	arg_36_1 = arg_36_1 or #arg_36_0._dataList

	local var_36_0 = arg_36_0.viewContainer:getListScrollParam()
	local var_36_1 = var_36_0.cellWidth
	local var_36_2 = var_36_0.endSpace
	local var_36_3 = arg_36_0:_getCellSpaceH()
	local var_36_4 = arg_36_0._hLayoutGroup.padding.left

	return (var_36_1 + var_36_3) * math.max(0, arg_36_1) - var_36_4 - var_36_1 / 2 + var_36_2
end

return var_0_0
